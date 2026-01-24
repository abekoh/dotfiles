#!/bin/bash

jq . > /tmp/claude_code_notification.json

SESSION_ID=$(jq -r '.session_id')
STOP_HOOK_ACTIVE=$(jq -r '.stop_hook_active')

# 無限ループを防ぐ
if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
    exit 0
fi

COMMON_GIT_PATH=$(realpath $(git rev-parse --git-common-dir) | sed -E 's#(\.git)?/?$##')
ORG_NAME=$(basename $(dirname "${COMMON_GIT_PATH}") | sed -e 's/\./_/g')
REPO_NAME=$(basename "${COMMON_GIT_PATH}" | sed -e 's/\./_/g')
BRANCH=$(git rev-parse --abbrev-ref HEAD | sed -e 's/\./_/g')
PRJ_NAME="${ORG_NAME}/${REPO_NAME}[${BRANCH}]"

terminal-notifier \
    -title "Claude Code 🤖" \
    -subtitle "$PRJ_NAME" \
    -message "Completed job." \
    -sound "Blow" \
    -group "claude-code-completion" \
    -execute "${HOME}/.cargo/bin/zellij action go-to-tab-name ${PRJ_NAME}"
