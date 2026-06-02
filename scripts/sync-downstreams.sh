#!/usr/bin/env bash
# Sync rule snapshots from this repo into downstream repos that publish or vendor them.
set -euo pipefail

SOURCE_DIR="${SOURCE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
OWNER="${DOWNSTREAM_OWNER:-cskwork}"
TOKEN="${DOWNSTREAM_SYNC_TOKEN:-}"
SOURCE_SHA="${SOURCE_SHA:-$(git -C "$SOURCE_DIR" rev-parse HEAD)}"
SHORT_SHA="${SOURCE_SHA:0:7}"
CHANGELOG_DATE="${CHANGELOG_DATE:-$(TZ=Asia/Seoul date +%F)}"
WORK_DIR="${WORK_DIR:-$(mktemp -d)}"
DRY_RUN="${DRY_RUN:-0}"

if [[ -z "$TOKEN" ]]; then
  cat >&2 <<'EOF'
DOWNSTREAM_SYNC_TOKEN is required.
Create a GitHub token with write access to cskwork/promptbox,
cskwork/ten-rules-skill, and cskwork/claude-code-config, then store it as:
  gh secret set DOWNSTREAM_SYNC_TOKEN --repo cskwork/coding-agent-rules
EOF
  exit 1
fi

cleanup() {
  if [[ -z "${WORK_DIR_KEEP:-}" && -d "$WORK_DIR" ]]; then
    rm -rf "$WORK_DIR"
  fi
}
trap cleanup EXIT

GIT_SYNC_AUTHOR_NAME="${GIT_AUTHOR_NAME:-coding-agent-rules-sync}"
GIT_SYNC_AUTHOR_EMAIL="${GIT_AUTHOR_EMAIL:-coding-agent-rules-sync@users.noreply.github.com}"

remote_url() {
  local repo="$1"
  printf 'https://github.com/%s/%s.git' "$OWNER" "$repo"
}

auth_header() {
  printf 'AUTHORIZATION: basic %s' "$(printf 'x-access-token:%s' "$TOKEN" | base64 | tr -d '\n')"
}

clone_sparse() {
  local repo="$1"
  local target="$2"
  shift 2

  GIT_TERMINAL_PROMPT=0 git \
    -c credential.helper= \
    -c "http.https://github.com/.extraheader=$(auth_header)" \
    clone --depth 1 --sparse "$(remote_url "$repo")" "$target" >/dev/null
  git -C "$target" config user.name "$GIT_SYNC_AUTHOR_NAME"
  git -C "$target" config user.email "$GIT_SYNC_AUTHOR_EMAIL"
  git -C "$target" config http.https://github.com/.extraheader "$(auth_header)"
  git -C "$target" sparse-checkout set "$@" >/dev/null
}

commit_and_push_if_changed() {
  local repo_dir="$1"
  local repo_name="$2"
  local commit_subject="$3"
  local commit_body="$4"

  if [[ -z "$(git -C "$repo_dir" status --porcelain)" ]]; then
    echo "No changes for $repo_name"
    return 0
  fi

  git -C "$repo_dir" add -A
  git -C "$repo_dir" commit -m "$commit_subject" -m "$commit_body"

  if [[ "$DRY_RUN" == "1" ]]; then
    echo "DRY_RUN=1, not pushing $repo_name"
  else
    git -C "$repo_dir" push origin main
  fi
}

replace_promptbox_payload() {
  local file="$1"
  local source_file="$2"

  node - "$file" "$source_file" <<'NODE'
const fs = require("node:fs");

const [file, sourceFile] = process.argv.slice(2);
const marker = "## 전체 본문 (복사용)\n\n```markdown\n";
const original = fs.readFileSync(file, "utf8");
const source = fs.readFileSync(sourceFile, "utf8").trimEnd();

const markerIndex = original.indexOf(marker);
if (markerIndex === -1) {
  throw new Error(`copy payload marker not found in ${file}`);
}

const bodyStart = markerIndex + marker.length;
const bodyEnd = original.indexOf("\n```", bodyStart);
if (bodyEnd === -1) {
  throw new Error(`copy payload closing fence not found in ${file}`);
}

const updated = original.slice(0, bodyStart) + source + original.slice(bodyEnd);
if (updated !== original) {
  fs.writeFileSync(file, updated);
}
NODE
}

sync_promptbox() {
  local repo_dir="$WORK_DIR/promptbox"
  clone_sparse promptbox "$repo_dir" src/content/configs

  replace_promptbox_payload "$repo_dir/src/content/configs/agents-md.md" "$SOURCE_DIR/AGENTS.md"
  replace_promptbox_payload "$repo_dir/src/content/configs/claude-md.md" "$SOURCE_DIR/CLAUDE.md"

  commit_and_push_if_changed \
    "$repo_dir" \
    promptbox \
    "docs: coding-agent-rules 자동 동기화" \
    "coding-agent-rules ${SOURCE_SHA}의 AGENTS.md/CLAUDE.md 본문을 promptbox config 페이지에 반영했다."
}

sync_ten_rules_skill() {
  local repo_dir="$WORK_DIR/ten-rules-skill"
  clone_sparse ten-rules-skill "$repo_dir" ref/coding

  cp "$SOURCE_DIR/AGENTS.md" "$repo_dir/ref/coding/ten-commandments.md"

  commit_and_push_if_changed \
    "$repo_dir" \
    ten-rules-skill \
    "docs: coding rules snapshot 자동 동기화" \
    "coding-agent-rules ${SOURCE_SHA}의 AGENTS.md를 ref/coding/ten-commandments.md에 반영했다."
}

append_claude_code_config_changelog() {
  local repo_dir="$1"
  local changelog="$repo_dir/docs/changelog/changelog-${CHANGELOG_DATE}.md"

  mkdir -p "$(dirname "$changelog")"
  if [[ ! -f "$changelog" ]]; then
    printf '# %s 변경 기록\n' "$CHANGELOG_DATE" >"$changelog"
  fi

  if grep -q "$SOURCE_SHA" "$changelog"; then
    return 0
  fi

  cat >>"$changelog" <<EOF

## coding-agent-rules 자동 동기화 (${SHORT_SHA})

- 목적: 배포용 공유본이 공통 원본과 달라지지 않게 한다.
- 결정: \`share/coding-agent-rules\`의 AGENTS.md, CLAUDE.md, README.md, README.ko.md를 coding-agent-rules \`${SOURCE_SHA}\` 기준으로 동기화했다.
- 영향: Claude Code 설정 배포본에서도 최신 코딩 에이전트 규칙을 그대로 사용한다.
EOF
}

sync_claude_code_config() {
  local repo_dir="$WORK_DIR/claude-code-config"
  clone_sparse claude-code-config "$repo_dir" share/coding-agent-rules docs/changelog

  cp "$SOURCE_DIR/AGENTS.md" "$repo_dir/share/coding-agent-rules/AGENTS.md"
  cp "$SOURCE_DIR/CLAUDE.md" "$repo_dir/share/coding-agent-rules/CLAUDE.md"
  cp "$SOURCE_DIR/README.md" "$repo_dir/share/coding-agent-rules/README.md"
  cp "$SOURCE_DIR/README.ko.md" "$repo_dir/share/coding-agent-rules/README.ko.md"
  if [[ -n "$(git -C "$repo_dir" status --porcelain -- share/coding-agent-rules)" ]]; then
    append_claude_code_config_changelog "$repo_dir"
  fi

  commit_and_push_if_changed \
    "$repo_dir" \
    claude-code-config \
    "docs: coding-agent-rules 자동 동기화" \
    "share/coding-agent-rules 공유본을 coding-agent-rules ${SOURCE_SHA} 기준으로 동기화했다."
}

sync_promptbox
sync_ten_rules_skill
sync_claude_code_config
