# PR Writing Guide

학생용 PR 본문은 “무엇을 바꿨는지”, “왜 그렇게 Git을 썼는지”, “무엇을 확인해야 하는지”를 짧게 드러내면 충분합니다.

## When to use

- `Issue 1` 기능 PR
- `Issue 2` draft PR
- `Issue 3` hotfix PR
- `Issue 3` feature update PR

## Recommended sections

아래 세 섹션을 기본 틀로 사용합니다.

### What changed

- 어떤 파일을 어떻게 바꿨는지
- 최종 값이나 중요한 문자열이 무엇인지

### Git choice

- 왜 이 상황에서 이런 Git 선택을 했는지
- 예:
  - fast-forward 가능 상태 확인
  - `stash push -u`, `stash pop`
  - `worktree`
  - `git merge origin/main`

### What to check

- 리뷰어가 무엇을 확인하면 되는지
- 예:
  - 최종 문자열이 맞는가
  - 불필요한 파일이 포함되지 않았는가
  - hotfix가 먼저 반영되었는가

## Example prompts by issue

### Issue 1 example

```md
## What changed

- add a release intro line to `README.md`
- set the release owner in `docs/release-checklist.md`

## Git choice

- this branch was intentionally kept ahead of `main` only
- I verified the fast-forward condition locally with `git merge --ff-only`

## What to check

- the new release intro line exists
- the release owner is updated
- no unrelated files were changed
```

### Issue 2 example

```md
## What changed

- draft the login notice text in `docs/release-checklist.md`
- add `NOTICE_REVIEW=team-alpha` to `config.txt`

## Git choice

- I used `git stash push -u` and `git stash pop` because the work was still draft-level and not ready to split into intermediate commits
- this PR should stay open until Issue 3 is completed

## What to check

- `customer notice` is `draft login notice`
- `NOTICE_REVIEW=team-alpha` exists
- `notes.txt` is not part of the final commit
```

### Issue 3 hotfix example

```md
## What changed

- fix the customer notice typo on `main`
- add a short hotfix note to `README.md`

## Git choice

- I used `worktree` so the in-progress feature work could stay dirty in the original directory
- this hotfix PR should be merged before the open feature PR

## What to check

- the hotfix branch was created from `main`
- the hotfix landed on `main` first
- the feature branch was not discarded during the hotfix work
```

### Issue 3 feature example

```md
## What changed

- keep the login notice work on `feature/login-notice`
- merge the latest `origin/main` after the hotfix PR
- resolve the conflict in `docs/release-checklist.md`
- keep the final line as `draft login notice after typo fix`

## Git choice

- `worktree` was used for the urgent hotfix path
- `git merge origin/main` was used so the feature branch could absorb the hotfix and show the merge commit clearly

## What to check

- the final `customer notice` line matches the agreed value
- the history now includes a merge commit
- the PR is now ready to merge
```
