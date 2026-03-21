# Fix release notice typo urgently

## Background

현재 feature 작업을 유지한 채 긴급 hotfix를 처리하고, 그 뒤 `main` 변경을 feature branch에 반영합니다.

## Branches

- feature: `feature/login-notice`
- hotfix: `hotfix/notice-typo`

## Tasks

- 먼저 현재 `feature/login-notice` branch에서 `app.txt` 맨 아래에 정확히 아래 한 줄을 추가해 미완성 변경을 만든다
  - `LOGIN_STATUS=in-progress`
- `worktree`로 `hotfix/notice-typo`를 열어 hotfix 작업과 PR을 먼저 진행한다
- hotfix worktree에서는 아래 두 수정을 한다
  - `README.md` 맨 아래에 `- hotfix typo shipped from main` 추가
  - `docs/release-checklist.md`의 아래 줄을 수정
    - before: `- customer notice: draft`
    - after: `- customer notice: typo fixed on main`
- hotfix PR을 먼저 `main`에 merge한다
- 원래 `feature/login-notice`로 돌아와 `main` 변경을 반영하고 PR을 마무리한다
- 마지막 conflict 해결 후 `docs/release-checklist.md`의 최종 값은 아래와 같아야 한다
  - `- customer notice: draft login notice after typo fix`

## Done when

- `hotfix/notice-typo -> main` PR이 먼저 merge되어 있다
- 기존 `feature/login-notice -> main` PR이 이후에 업데이트되어 merge되어 있다
- 마지막에 `docs/release-checklist.md` conflict를 해결했다
- `app.txt`, `README.md`, `docs/release-checklist.md`에 요구한 최종 문자열이 모두 반영되어 있다
