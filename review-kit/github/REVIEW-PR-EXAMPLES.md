# Review PR Examples

이번 문서는 `review-kit` 실습에서 바로 참고할 수 있는 PR 본문 예시를 모아 둔 문서입니다.  
일반적인 PR 작성 원칙은 [PR-WRITING-GUIDE.md](./PR-WRITING-GUIDE.md)를 먼저 봅니다.

## Issue 1 example

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

## Issue 2 example

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

## Issue 3 hotfix example

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

## Issue 3 feature example

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
