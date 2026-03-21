# Issue 1. Add release intro

## Goal

릴리즈 소개 문구를 추가하고, `main`과 feature branch 사이에 fast-forward 가능한 상태를 만듭니다.

## Branch

`feature/release-intro`

## Files to change

- `README.md`
- `docs/release-checklist.md`

## Work to do

- `README.md` 맨 아래에 `- release intro ready for review` 한 줄 추가
- `docs/release-checklist.md`의 `- release owner: TBD`를 자기 이름으로 변경

## Git checkpoints

- commit 후 로컬 검사용 branch에서 `git merge --ff-only`를 실행해 fast-forward 가능 상태를 확인한다.
- 실제 `main` 반영은 GitHub PR merge로 진행한다.

## Done when

- `feature/release-intro -> main` PR이 merge되어 있다
- 왜 이 상태가 fast-forward 가능했는지 설명할 수 있다

## Reflection

1. 왜 이 경우에는 새 merge commit이 꼭 필요하지 않았나요?
2. GitHub PR merge와 로컬 fast-forward는 왜 완전히 같은 개념이 아니라고 말할 수 있을까요?
