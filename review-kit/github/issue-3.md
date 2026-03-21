# Issue 3. Fix release notice typo urgently

## Goal

현재 feature 작업을 유지한 채 `worktree`로 hotfix를 병렬 처리하고, 이후 `main`을 feature에 merge하면서 merge commit과 conflict를 함께 복습합니다.

## Branches

- current feature: `feature/login-notice`
- hotfix: `hotfix/notice-typo`

## Files to change

- `app.txt`
- `README.md`
- `docs/release-checklist.md`

## Work to do

### In the current feature branch

- `app.txt`에 미완성 변경 하나를 추가해 dirty 상태를 만든다

### In a new worktree

- `main` 기준 `hotfix/notice-typo` branch를 생성한다
- `docs/release-checklist.md`의 `customer notice` 줄을 hotfix 버전으로 수정한다
- `README.md`에 hotfix 안내 한 줄을 추가한다
- hotfix PR을 먼저 merge한다

### Back in the feature branch

- 원래 작업 디렉터리의 변경이 그대로 남아 있는지 확인한다
- `app.txt` 변경을 commit 한다
- `git merge origin/main`을 실행한다
- `docs/release-checklist.md`의 conflict를 해결한다
- 기존 `feature/login-notice` PR을 업데이트하고 merge한다

## Final value to keep

아래 줄을 최종 값으로 사용합니다.

```text
- customer notice: draft login notice after typo fix
```

## Git checkpoints

- `git worktree list`
- `git worktree add`
- `git worktree remove`
- `git merge origin/main`
- conflict marker 읽기와 해결

## Done when

- hotfix PR이 먼저 merge되어 있다
- 기존 feature PR이 이후에 update되어 merge되어 있다
- 왜 마지막 통합에서 merge commit과 conflict가 함께 생겼는지 설명할 수 있다

## Reflection

1. 왜 여기서는 stash보다 worktree가 더 자연스러웠나요?
2. conflict는 왜 Git이 자동으로 해결하지 못했나요?
3. hotfix를 먼저 merge했기 때문에 feature branch에는 어떤 일이 생겼나요?
