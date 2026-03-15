# cherry-pick

한 줄 요약: 브랜치 전체가 아니라 특정 commit 하나만 골라서 현재 브랜치에 적용하고 싶을 때 쓰는 도구입니다.

- 수업 흐름: [Session 2 Lab](../../session-2-lab.md)
- 비교 시나리오: [02-merge-commit](../02-merge-commit/README.md), [09-revert](../09-revert/README.md)

## 언제 쓰는가

- hotfix 브랜치 전체는 필요 없고, 그중 특정 수정 하나만 다른 브랜치에 반영하고 싶을 때
- 릴리스 브랜치나 긴급 패치 흐름에서 필요한 commit만 선별해 옮기고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab cherry-pick
git lg
git log --oneline hotfix/typo
```

## 실습 절차

```bash
git switch main
git cherry-pick <Fix customer-facing typo in README 커밋 해시>
git lg
git status -sb
```

복구를 보여주고 싶다면 아래도 함께 소개합니다.

```bash
git cherry-pick --abort
```

## 명령과 옵션 풀이

- `./bin/reset-lab cherry-pick`: cherry-pick 실습 시작 상태를 만듭니다.
- `git lg`: 현재 브랜치 관계를 그래프로 확인합니다.
- `git log --oneline hotfix/typo`: `log`는 commit 기록을 보고, `--oneline`은 각 commit을 한 줄로 압축해서 보여줍니다. `hotfix/typo`는 조회할 브랜치 이름입니다.
- `git switch main`: commit을 가져올 대상 브랜치를 `main`으로 맞춥니다.
- `git cherry-pick <Fix customer-facing typo in README 커밋 해시>`: `cherry-pick`은 특정 commit의 변경만 현재 브랜치에 적용합니다. 꺾쇠 괄호 안의 값은 실제 commit hash로 바꿔 입력해야 합니다.
- `git status -sb`: 적용 후 충돌이 없는지와 작업 상태를 짧게 확인합니다.
- `git cherry-pick --abort`: cherry-pick 도중 conflict가 나서 중단하고 싶을 때 시작 전 상태로 되돌립니다.

## 관찰 포인트

- cherry-pick 후 `main`에 새 commit이 생기지만 hash는 원래와 다릅니다.
- 가져온 내용은 같아도, 현재 브랜치에 새로 기록된 commit이기 때문입니다.
- 브랜치 전체 이력은 합쳐지지 않고 선택한 commit만 들어옵니다.

## 핵심 개념

- cherry-pick은 “브랜치 이동”이 아니라 “특정 commit의 변경 내용을 현재 브랜치에 다시 적용”하는 작업입니다.
- 수술처럼 정확하지만, 나중에 같은 변경을 다시 merge할 때 중복 맥락을 만들 수 있습니다.

## 자주 헷갈리는 포인트

- cherry-pick은 merge의 축소판이 아닙니다.
- commit 하나만 옮길 뿐, 원래 브랜치와의 관계를 정리해 주지는 않습니다.
- cherry-pick 중에도 conflict가 날 수 있습니다.

## 비교 대상

- [02-merge-commit](../02-merge-commit/README.md): 브랜치 전체 흐름을 함께 합칩니다.
- [09-revert](../09-revert/README.md): 기존 commit을 취소하는 방향의 새 commit을 만듭니다.

## 질문 거리

1. 왜 cherry-pick한 commit의 hash는 원본과 다를까요?
2. 어떤 상황에서는 cherry-pick보다 merge가 더 낫나요?
3. cherry-pick을 많이 쓰면 히스토리 관리가 왜 어려워질 수 있을까요?
