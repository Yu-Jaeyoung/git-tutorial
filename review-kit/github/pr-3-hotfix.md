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
