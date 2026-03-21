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
