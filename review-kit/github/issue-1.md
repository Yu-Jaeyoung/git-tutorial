# Add release intro

## Background

릴리즈 소개 문구와 release owner 정보를 정리합니다.

## Branch

`feature/release-intro`

## Tasks

- `README.md` 맨 아래에 정확히 아래 한 줄을 추가
  - `- release intro ready for review`
- `docs/release-checklist.md`의 아래 줄을 자기 이름으로 변경
  - before: `- release owner: TBD`
  - after example: `- release owner: Jaeyoung`
- PR 생성 후 `main`에 merge

## Done when

- `feature/release-intro -> main` PR이 merge되어 있다
- 변경 파일이 `README.md`, `docs/release-checklist.md`로 제한되어 있다
- `README.md`와 `docs/release-checklist.md`에 요구한 문자열이 정확히 들어가 있다
