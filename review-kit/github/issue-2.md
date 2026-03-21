# Draft login notice

## Background

고객 공지 초안을 준비하되, 중간 작업을 잠깐 치웠다가 다시 복원하는 흐름을 함께 연습합니다.

## Branch

`feature/login-notice`

## Tasks

- `docs/release-checklist.md`의 아래 줄을 수정
  - before: `- customer notice: draft`
  - after: `- customer notice: draft login notice`
- `config.txt` 맨 아래에 정확히 아래 한 줄 추가
  - `NOTICE_REVIEW=team-alpha`
- 루트에 `notes.txt` 파일을 새로 만든다
- 위 세 변경을 만든 뒤, 중간에 `stash`를 사용해 작업을 잠깐 치웠다가 복원
- draft PR 생성

## Done when

- `feature/login-notice -> main` draft PR이 열려 있다
- 최종 commit에는 `notes.txt`가 포함되지 않는다
- 이 PR은 아직 merge하지 않는다
- `docs/release-checklist.md`와 `config.txt`에는 요구한 값이 반영되어 있다
