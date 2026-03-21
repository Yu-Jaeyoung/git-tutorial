# Fix release notice typo urgently

## Background

현재 feature 작업을 유지한 채 긴급 hotfix를 처리하고, 그 뒤 `main` 변경을 feature branch에 반영합니다.

## Branches

- feature: `feature/login-notice`
- hotfix: `hotfix/notice-typo`

## Tasks

- 현재 feature branch에 미완성 변경을 하나 더 만든다
- `worktree`로 `hotfix/notice-typo`를 열어 hotfix 작업과 PR을 먼저 진행한다
- hotfix PR을 먼저 `main`에 merge한다
- 원래 `feature/login-notice`로 돌아와 `main` 변경을 반영하고 PR을 마무리한다

## Done when

- `hotfix/notice-typo -> main` PR이 먼저 merge되어 있다
- 기존 `feature/login-notice -> main` PR이 이후에 업데이트되어 merge되어 있다
- 마지막에 `docs/release-checklist.md` conflict를 해결했다
