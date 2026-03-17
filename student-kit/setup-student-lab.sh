#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_INPUT="${1:-generated/git-workshop-lab}"

if [[ "$TARGET_INPUT" = /* ]]; then
  TARGET_DIR="$TARGET_INPUT"
else
  TARGET_DIR="$SCRIPT_DIR/$TARGET_INPUT"
fi

if [ -e "$TARGET_DIR" ]; then
  echo "Target already exists: $TARGET_DIR" >&2
  echo "Choose a new path or remove the existing directory first." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

git init -b main >/dev/null
git config user.name "Workshop Instructor"
git config user.email "workshop@example.com"
git config commit.gpgsign false
git config tag.gpgsign false
git config alias.lg "log --graph --decorate --decorate-refs=refs/heads/* --decorate-refs=HEAD --oneline --branches"
git config alias.lga "log --graph --decorate --oneline --all"
git config alias.st "status -sb"

mkdir -p bin docs

cat <<'EOF' > README.md
# Git Workshop Student Lab

이 저장소는 Git 명령을 반복 실습하기 위한 학생용 샌드박스입니다.

## 시작 방법

```bash
./bin/reset-lab merge-ff
git status -sb
git lg
```

## 추천 순서

1. merge-ff
2. merge-commit
3. conflict
4. stash
5. worktree
6. rebase
7. interactive-rebase
8. cherry-pick
9. revert
10. reset
11. tag

`rebase-conflict`는 `rebase` 단계 안에서 함께 연습하는 abort drill입니다.

## 매 단계 공통 체크

- 현재 브랜치가 무엇인지 확인한다.
- `git status -sb`로 working tree가 어떻게 바뀌는지 본다.
- `git lg`로 브랜치와 커밋 그래프가 어떻게 달라졌는지 본다.
- 새 커밋이 생겼는지, 기존 커밋 hash가 바뀌었는지 구분한다.
- 실수했으면 `./bin/reset-lab <scenario>`로 같은 시작 상태를 다시 만든다.

## 보조 명령

- `git lg`: 현재 수업용 브랜치만 그래프로 본다.
- `git lga`: 숨겨진 시나리오 태그까지 포함해서 전체 ref를 본다.
EOF

cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=disabled
PAYMENT_STATUS=planned
NOTIFICATION_MODE=email
EOF

cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=1
EOF

cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment

## Team notes
- login feature is not ready
- payment flow is under review
EOF

cat <<'EOF' > bin/reset-lab
#!/usr/bin/env bash
set -euo pipefail

SCENARIO="${1:-}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKTREE_ROOT="$(cd "$ROOT_DIR/.." && pwd)/git-workshop-worktrees"

usage() {
  cat <<'USAGE'
Usage: ./bin/reset-lab <scenario>

Scenarios:
  merge-ff
  merge-commit
  conflict
  stash
  worktree
  rebase
  rebase-conflict
  interactive-rebase
  cherry-pick
  revert
  reset
  tag
USAGE
}

cleanup_lab_worktrees() {
  mkdir -p "$WORKTREE_ROOT"

  while IFS= read -r path; do
    case "$path" in
      "$WORKTREE_ROOT"/*)
        git worktree remove --force "$path" >/dev/null 2>&1 || true
        ;;
    esac
  done < <(git worktree list --porcelain | awk '/^worktree / { print $2 }')

  git worktree prune >/dev/null 2>&1 || true
  rmdir "$WORKTREE_ROOT" >/dev/null 2>&1 || true
}

abort_in_progress() {
  git merge --abort >/dev/null 2>&1 || true
  git rebase --abort >/dev/null 2>&1 || true
  git cherry-pick --abort >/dev/null 2>&1 || true
  git revert --abort >/dev/null 2>&1 || true
  git am --abort >/dev/null 2>&1 || true
}

drop_branch_if_exists() {
  local branch="$1"

  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git branch -D "$branch" >/dev/null 2>&1 || true
  fi
}

reset_common() {
  cd "$ROOT_DIR"
  abort_in_progress
  cleanup_lab_worktrees
  git reset --hard -q
  git clean -fdq
  git switch -q --detach checkpoint/base
  drop_branch_if_exists feature/login
  drop_branch_if_exists feature/payment
  drop_branch_if_exists hotfix/typo
  drop_branch_if_exists hotfix/readme-typo
  git branch -f main checkpoint/base >/dev/null
}

set_scenario_branches() {
  case "$SCENARIO" in
    merge-ff)
      git branch -f main scenario/merge-ff/main >/dev/null
      git branch -f feature/login scenario/merge-ff/feature-login >/dev/null
      git switch -q main
      ;;
    merge-commit)
      git branch -f main scenario/merge-commit/main >/dev/null
      git branch -f feature/login scenario/merge-commit/feature-login >/dev/null
      git switch -q main
      ;;
    conflict)
      git branch -f main scenario/conflict/main >/dev/null
      git branch -f feature/login scenario/conflict/feature-login >/dev/null
      git switch -q main
      ;;
    stash)
      git branch -f main scenario/stash/main >/dev/null
      git branch -f feature/login scenario/stash/feature-login >/dev/null
      git switch -q feature/login
      ;;
    worktree)
      git branch -f main scenario/worktree/main >/dev/null
      git branch -f feature/login scenario/worktree/feature-login >/dev/null
      git switch -q feature/login
      ;;
    rebase)
      git branch -f main scenario/rebase/main >/dev/null
      git branch -f feature/payment scenario/rebase/feature-payment >/dev/null
      git switch -q feature/payment
      ;;
    rebase-conflict)
      git branch -f main scenario/rebase-conflict/main >/dev/null
      git branch -f feature/payment scenario/rebase-conflict/feature-payment >/dev/null
      git switch -q feature/payment
      ;;
    interactive-rebase)
      git branch -f main scenario/interactive-rebase/main >/dev/null
      git branch -f feature/payment scenario/interactive-rebase/feature-payment >/dev/null
      git switch -q feature/payment
      ;;
    cherry-pick)
      git branch -f main scenario/cherry-pick/main >/dev/null
      git branch -f hotfix/readme-typo scenario/cherry-pick/hotfix-readme-typo >/dev/null
      git switch -q main
      ;;
    revert)
      git branch -f main scenario/revert/main >/dev/null
      git switch -q main
      ;;
    reset)
      git branch -f main scenario/reset/main >/dev/null
      git switch -q main
      ;;
    tag)
      git branch -f main scenario/tag/main >/dev/null
      git switch -q main
      ;;
    *)
      usage >&2
      exit 1
      ;;
  esac
}

if [ -z "$SCENARIO" ]; then
  usage >&2
  exit 1
fi

reset_common
set_scenario_branches
git reset --hard -q
git clean -fdq

echo "Scenario ready: $SCENARIO"
git status -sb
EOF

chmod +x bin/reset-lab

git add .
git commit -m "Initial workshop baseline" >/dev/null
git tag checkpoint/base

git tag scenario/merge-ff/main main
git switch -q -c tmp/merge-ff-feature-login checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=review
PAYMENT_STATUS=planned
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "Add login banner copy" >/dev/null
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment

## Team notes
- login feature is ready for review
- payment flow is under review
- login fields: email, password, remember me
EOF
git add docs/guide.md
git commit -m "Document login fields" >/dev/null
git tag scenario/merge-ff/feature-login HEAD
git switch -q main
git branch -D tmp/merge-ff-feature-login >/dev/null

git switch -q -c tmp/merge-commit-main checkpoint/base
cat <<'EOF' > README.md
# Git Workshop Lab

This repository is a disposable sandbox for Git practice.

Main branch now includes a release note update.

Use the helper to jump back to a known checkpoint:

```bash
./bin/reset-lab merge-ff
git lg
```
EOF
git add README.md
git commit -m "Update release note on main" >/dev/null
git tag scenario/merge-commit/main HEAD
git switch -q -c tmp/merge-commit-feature-login checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=beta
PAYMENT_STATUS=planned
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "Draft login rollout note" >/dev/null
git tag scenario/merge-commit/feature-login HEAD
git switch -q main
git branch -D tmp/merge-commit-main >/dev/null
git branch -D tmp/merge-commit-feature-login >/dev/null

git switch -q -c tmp/conflict-main checkpoint/base
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from main rollout
PAYMENT_RETRY=1
EOF
git add config.txt
git commit -m "Tune welcome message on main" >/dev/null
git tag scenario/conflict/main HEAD
git switch -q -c tmp/conflict-feature-login checkpoint/base
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from login rollout
PAYMENT_RETRY=1
EOF
git add config.txt
git commit -m "Tune welcome message for login feature" >/dev/null
git tag scenario/conflict/feature-login HEAD
git switch -q main
git branch -D tmp/conflict-main >/dev/null
git branch -D tmp/conflict-feature-login >/dev/null

git tag scenario/stash/main main
git switch -q -c tmp/stash-feature-login checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=in-progress
PAYMENT_STATUS=planned
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "Start login draft" >/dev/null
git tag scenario/stash/feature-login HEAD
git switch -q main
git branch -D tmp/stash-feature-login >/dev/null

git switch -q -c tmp/worktree-main checkpoint/base
cat <<'EOF' > README.md
# Git Workshop Lab

This repository is a disposable sandbox for Git practice.

Release checklist wording was refreshed on main.

Use the helper to jump back to a known checkpoint:

```bash
./bin/reset-lab merge-ff
git lg
```
EOF
git add README.md
git commit -m "Refresh release checklist wording" >/dev/null
git tag scenario/worktree/main HEAD
git switch -q -c tmp/worktree-feature-login checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=copy-review
PAYMENT_STATUS=planned
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "Prepare login copy review" >/dev/null
git tag scenario/worktree/feature-login HEAD
git switch -q main
git branch -D tmp/worktree-main >/dev/null
git branch -D tmp/worktree-feature-login >/dev/null

git switch -q -c tmp/rebase-main checkpoint/base
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment
- prepare payment rollout note

## Team notes
- login feature is not ready
- payment flow is under review
EOF
git add docs/guide.md
git commit -m "Prepare payment rollout notes" >/dev/null
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=2
EOF
git add config.txt
git commit -m "Tune payment retry on main" >/dev/null
git tag scenario/rebase/main HEAD
git switch -q -c tmp/rebase-feature-payment checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=disabled
PAYMENT_STATUS=development
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "Add payment status flag" >/dev/null
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment

## Team notes
- login feature is not ready
- payment flow needs QA sign-off
EOF
git add docs/guide.md
git commit -m "Document payment QA path" >/dev/null
git tag scenario/rebase/feature-payment HEAD
git switch -q main
git branch -D tmp/rebase-main >/dev/null
git branch -D tmp/rebase-feature-payment >/dev/null

git switch -q -c tmp/rebase-conflict-main checkpoint/base
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment
- payment retry confirmed by ops

## Team notes
- login feature is not ready
- payment flow is under review
EOF
git add docs/guide.md
git commit -m "Add payment ops note on main" >/dev/null
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=4
EOF
git add config.txt
git commit -m "Set payment retry to 4 on main" >/dev/null
git tag scenario/rebase-conflict/main HEAD
git switch -q -c tmp/rebase-conflict-feature-payment checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=disabled
PAYMENT_STATUS=qa-review
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "Move payment flow to QA review" >/dev/null
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=6
EOF
git add config.txt
git commit -m "Set payment retry to 6 for beta testing" >/dev/null
git tag scenario/rebase-conflict/feature-payment HEAD
git switch -q main
git branch -D tmp/rebase-conflict-main >/dev/null
git branch -D tmp/rebase-conflict-feature-payment >/dev/null

git tag scenario/interactive-rebase/main main
git switch -q -c tmp/interactive-rebase-feature-payment checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=disabled
PAYMENT_STATUS=draft-copy
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "draft payment copy" >/dev/null
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=2
EOF
git add config.txt
git commit -m "wip payment validation" >/dev/null
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment

## Team notes
- login feature is not ready
- payment validation typo fixed
EOF
git add docs/guide.md
git commit -m "typo in payment validation" >/dev/null
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=disabled
PAYMENT_STATUS=validation-debug
NOTIFICATION_MODE=email
EOF
git add app.txt
git commit -m "remove debug log" >/dev/null
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment
- obsolete sandbox note

## Team notes
- login feature is not ready
- payment validation typo fixed
EOF
git add docs/guide.md
git commit -m "obsolete sandbox note" >/dev/null
git tag scenario/interactive-rebase/feature-payment HEAD
git switch -q main
git branch -D tmp/interactive-rebase-feature-payment >/dev/null

git switch -q -c tmp/cherry-pick-main checkpoint/base
cat <<'EOF' > app.txt
APP_NAME=git-workshop
LOGIN_STATUS=disabled
PAYMENT_STATUS=planned
NOTIFICATION_MODE=slack
EOF
git add app.txt
git commit -m "Update notification channel on main" >/dev/null
git tag scenario/cherry-pick/main HEAD
git switch -q -c tmp/cherry-pick-hotfix-readme-typo checkpoint/base
cat <<'EOF' > README.md
# Git Workshop Lab

This repository is a disposable sandbox for Git practice.

Fix customer-facing typo in the release checklist.

Use the helper to jump back to a known checkpoint:

```bash
./bin/reset-lab merge-ff
git lg
```
EOF
git add README.md
git commit -m "Fix customer-facing typo in README" >/dev/null
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment

## Team notes
- docs cleanup finished for hotfix branch
- payment flow is under review
EOF
git add docs/guide.md
git commit -m "Clean up guide wording on hotfix branch" >/dev/null
git tag scenario/cherry-pick/hotfix-readme-typo HEAD
git switch -q main
git branch -D tmp/cherry-pick-main >/dev/null
git branch -D tmp/cherry-pick-hotfix-readme-typo >/dev/null

git switch -q -c tmp/revert-main checkpoint/base
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=info
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=9
EOF
git add config.txt
git commit -m "Ship incorrect payment retry value" >/dev/null
git tag scenario/revert/main HEAD
git switch -q main
git branch -D tmp/revert-main >/dev/null

git switch -q -c tmp/reset-main checkpoint/base
cat <<'EOF' > README.md
# Git Workshop Lab

This repository is a disposable sandbox for Git practice.

Release summary added for reset practice.

Use the helper to jump back to a known checkpoint:

```bash
./bin/reset-lab merge-ff
git lg
```
EOF
git add README.md
git commit -m "Add release summary" >/dev/null
cat <<'EOF' > config.txt
PORT=3000
LOG_LEVEL=warn
WELCOME_MESSAGE=Hello from the workshop
PAYMENT_RETRY=1
EOF
git add config.txt
git commit -m "Tune notification level" >/dev/null
cat <<'EOF' > docs/guide.md
# Guide

## Release checklist
- update README
- verify config
- announce deployment
- rehearse rollback drill

## Team notes
- login feature is not ready
- payment flow is under review
EOF
git add docs/guide.md
git commit -m "Add rollback drill note" >/dev/null
git tag scenario/reset/main HEAD
git switch -q main
git branch -D tmp/reset-main >/dev/null

git switch -q -c tmp/tag-main checkpoint/base
printf '\nRelease prep: define tag practice checkpoints.\n' >> README.md
git add README.md
git commit -m "Document release prep note" >/dev/null
printf '\nRELEASE_CHANNEL=stable\n' >> config.txt
git add config.txt
git commit -m "Mark stable release channel" >/dev/null
printf '\n## Tag lab\n- define release names\n- practice detached HEAD\n' >> docs/guide.md
git add docs/guide.md
git commit -m "Add tag lab checklist" >/dev/null
git tag scenario/tag/main HEAD
git switch -q main
git branch -D tmp/tag-main >/dev/null

git switch -q main

printf '\nStudent lab created at %s\n' "$TARGET_DIR"
printf 'Next steps:\n'
printf '  cd %s\n' "$TARGET_DIR"
printf '  ./bin/reset-lab merge-ff\n'
printf '  git status -sb\n'
printf '  git lg\n'
