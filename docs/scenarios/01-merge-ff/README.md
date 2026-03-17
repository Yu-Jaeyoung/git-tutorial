# merge-ff

한 줄 요약: `main`이 `feature/login`의 조상일 때 `merge`는 새 commit 없이 포인터만 앞으로 이동할 수 있습니다.

- 비교 시나리오: [02-merge-commit](../02-merge-commit/README.md)

## 언제 쓰는가

- `main`에는 새 작업이 없고, feature 브랜치만 앞서 나가 있을 때
- 학습자에게 “merge가 항상 merge commit을 만드는 것은 아니다”를 보여주고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab merge-ff
git lg
```

## 실습 절차

```bash
git switch main
git merge feature/login
git lg
git status -sb
```

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- merge-ff 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- `git merge` 후 새 merge commit이 생기지 않습니다.
- `main`만 앞으로 이동하고 `feature/login`은 원래 commit을 그대로 가리킵니다.
- `git status -sb`는 working tree가 깨끗하다고 보여줍니다.

## 핵심 개념

- fast-forward는 “병합”이라기보다 “branch 포인터가 앞선 commit으로 이동하는 것”에 가깝습니다.
- 조건은 간단합니다. `main`이 `feature/login`의 조상이어야 합니다.

## 자주 헷갈리는 포인트

- `git merge`를 실행했다고 해서 항상 merge commit이 생기지는 않습니다.
- fast-forward가 가능해도 팀 정책상 `--no-ff`를 강제하는 경우는 있지만, 이 시나리오의 목적은 기본 동작 이해입니다.

## 비교 대상

- [02-merge-commit](../02-merge-commit/README.md): 양쪽 브랜치가 모두 앞서 있으면 새 merge commit이 생깁니다.

## 질문 거리

1. 왜 이 경우에는 Git이 새 commit을 만들 필요가 없을까요?
2. fast-forward가 가능하다는 사실은 커밋 그래프에서 어떻게 보일까요?
3. 팀이 일부러 `--no-ff`를 쓰는 이유는 언제 생길까요?
