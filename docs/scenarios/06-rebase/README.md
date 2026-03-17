# rebase

한 줄 요약: feature 브랜치의 commit들을 최신 `main` 뒤로 다시 적용해, 더 직선적인 이력을 만드는 도구입니다.

- 비교 시나리오: [02-merge-commit](../02-merge-commit/README.md), [07-interactive-rebase](../07-interactive-rebase/README.md)

## 언제 쓰는가

- PR 전에 내 feature 브랜치를 최신 `main` 기준으로 정리하고 싶을 때
- 아직 다른 사람이 쓰지 않는 로컬 브랜치 히스토리를 깔끔하게 만들고 싶을 때
- merge commit 없이 더 직선적인 그래프를 보고 싶을 때

## 시작 상태 만들기

기본 rebase 실습:

```bash
./bin/reset-lab rebase
git lg
```

충돌과 `--abort` 실습:

```bash
./bin/reset-lab rebase-conflict
git lg
```

## 실습 1: 충돌 없이 rebase하기

```bash
git switch feature/payment
git rebase main
git lg
git status -sb
```

## 실습 2: 충돌을 만들고 `git rebase --abort` 해보기

```bash
./bin/reset-lab rebase-conflict
git lg
git switch feature/payment
git rebase main
git status -sb
```

이 시점에 `config.txt`를 열면 conflict marker가 보입니다. 이번 실습에서는 해결하지 말고 되돌립니다.

```bash
git rebase --abort
git lg
git status -sb
```

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- rebase 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- rebase 전후로 `feature/payment`의 commit hash가 바뀝니다.
- `git lg`를 보면 갈라져 있던 feature commit이 최신 `main` 뒤에 다시 놓입니다.
- 충돌형 시나리오에서는 `git rebase main` 직후 working tree가 멈추고 `git status -sb`가 충돌 상태를 보여줍니다.
- `git rebase --abort` 후에는 rebase 시작 전 그래프와 브랜치 위치로 되돌아옵니다.

## 협업에서 무슨 일이 생기는가

- 내가 rebase한 브랜치는 commit hash가 바뀌므로, 같은 내용처럼 보여도 Git 입장에서는 “다른 commit들”이 됩니다.
- 다른 사람이 옛 commit을 기준으로 작업하고 있었다면, 내 rebase 후에는 서로 보는 히스토리가 달라집니다.
- 이미 원격에 올린 브랜치를 rebase하면 보통 일반 `push`는 거절됩니다. 원격 기준으로는 non-fast-forward 업데이트이기 때문입니다.
- 이때 억지로 올리려면 보통 `git push --force-with-lease`가 필요하지만, 협업 중이라면 먼저 팀과 조율하는 편이 안전합니다.

## commit hash는 다르지만 내용이 같으면 push 가능한가

- 가능합니다. 다만 조건이 있습니다.
- Git은 commit hash가 다르면 내용이 비슷해도 다른 commit으로 취급합니다.
- 원격 브랜치가 아직 그 이전 히스토리를 갖고 있지 않거나, 현재 브랜치 업데이트가 fast-forward라면 일반 `push`가 됩니다.
- 반대로 원격이 이미 rebase 전 히스토리를 가지고 있으면, 내용이 같아 보여도 일반 `push`는 대개 거절됩니다.
- 이 경우에는 강제 push가 필요할 수 있고, 그 순간부터는 협업 리스크가 생깁니다.

## rebase가 좋은 경우 vs merge가 좋은 경우

### rebase가 좋은 경우

- 아직 공유하지 않은 로컬 feature 브랜치를 정리할 때
- PR 전에 commit 흐름을 직선형으로 읽기 좋게 만들고 싶을 때
- 최신 `main` 변경을 feature에 반영하되 merge commit을 늘리고 싶지 않을 때

### merge가 좋은 경우

- 이미 여러 사람이 함께 쓰는 브랜치 히스토리를 보존해야 할 때
- 실제로 어떤 브랜치가 어떤 시점에 합쳐졌는지 그래프 그대로 남기고 싶을 때
- history rewrite 없이 안전하게 통합하고 싶을 때

## 핵심 개념

- rebase는 기존 commit을 이동시키는 느낌이지만, 실제로는 새 commit을 다시 만드는 작업에 가깝습니다.
- 그래서 hash가 바뀌고, 이미 공유한 branch에는 조심해서 써야 합니다.
- merge와 rebase는 둘 다 통합 도구지만, 히스토리를 표현하는 방식이 다릅니다.

## 자주 헷갈리는 포인트

- rebase는 merge의 “상위호환”이 아닙니다.
- rebase를 했다고 해서 `main`에 자동으로 통합된 것은 아닙니다. 통합은 별도 단계입니다.
- conflict는 rebase 중에도 날 수 있고, 그럴 때 `git rebase --abort`가 안전한 탈출구가 됩니다.

## 비교 대상

- [02-merge-commit](../02-merge-commit/README.md): 갈라진 이력을 있는 그대로 결합합니다.
- [07-interactive-rebase](../07-interactive-rebase/README.md): 최신 `main` 위로 옮기는 것에 더해 commit 구조까지 정리합니다.

## 질문 거리

1. rebase 후 commit hash가 바뀌는 이유는 무엇일까요?
2. 왜 공유된 브랜치에서는 rebase를 조심해야 할까요?
3. 내용이 같아도 hash가 다른 commit은 원격에서 왜 다른 객체로 취급될까요?
4. `git rebase --abort`는 정확히 무엇을 되돌린다고 이해하면 좋을까요?
5. 어떤 상황에서는 merge가 rebase보다 더 좋은 기본값일까요?
