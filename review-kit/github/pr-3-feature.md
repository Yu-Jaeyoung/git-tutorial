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
