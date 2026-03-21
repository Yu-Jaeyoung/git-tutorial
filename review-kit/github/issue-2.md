# Issue 2. Draft login notice

## Goal

아직 commit하기 애매한 변경을 잠깐 치웠다가 다시 복원하는 `stash` 흐름을 복습합니다.

## Branch

`feature/login-notice`

## Files to change

- `docs/release-checklist.md`
- `config.txt`
- `notes.txt` (untracked)

## Work to do

- `docs/release-checklist.md`의 `- customer notice: draft`를 `- customer notice: draft login notice`로 변경
- `config.txt` 맨 아래에 `NOTICE_REVIEW=team-alpha` 추가
- `notes.txt` 파일 생성

## Git checkpoints

- `git stash push -u`로 tracked + untracked 변경을 함께 치운다
- `git stash pop`으로 변경을 복원한다
- 작업을 정리한 뒤 PR을 만든다

## Important

- 이 PR은 열되 아직 merge하지 않습니다.
- 다음 `Issue 3`에서 같은 branch를 이어서 사용합니다.

## Done when

- `feature/login-notice -> main` draft PR이 열려 있다
- `notes.txt`까지 stash에 들어갔다는 점을 확인했다
- `apply`가 아니라 `pop`을 왜 썼는지 설명할 수 있다

## Reflection

1. 왜 이 상황에서는 commit보다 stash가 더 자연스러웠나요?
2. `-u`가 없으면 어떤 파일이 stash에 들어가지 않나요?
