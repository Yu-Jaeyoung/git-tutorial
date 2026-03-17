# merge-commit

한 줄 요약: 양쪽 브랜치가 공통 조상 이후 각각 달라졌다면 `merge`는 두 부모를 가진 새 commit을 만듭니다.

- 비교 시나리오: [01-merge-ff](../01-merge-ff/README.md), [06-rebase](../06-rebase/README.md)

## 언제 쓰는가

- `main`과 feature 브랜치가 모두 각자 진행되어 두 줄기 이력을 유지하고 싶을 때
- merge commit의 의미를 fast-forward와 대비해서 설명하고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab merge-commit
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
- merge-commit 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- `git merge` 후 새 merge commit이 생깁니다.
- 새 commit에는 부모가 둘 있습니다. 하나는 원래 `main`, 다른 하나는 `feature/login`입니다.
- `git lg`를 보면 두 줄기의 이력이 합쳐진 형태가 남습니다.

## 핵심 개념

- merge commit은 “양쪽 브랜치의 결과를 모두 포함했다”는 기록입니다.
- fast-forward와 달리 기존 이력의 갈라짐 자체가 그래프에 남습니다.

## 자주 헷갈리는 포인트

- merge commit은 “중복 commit”이 아니라 두 줄기 이력을 연결하는 결합점입니다.
- merge commit이 있다고 해서 conflict가 반드시 있었다는 뜻은 아닙니다.

## 비교 대상

- [01-merge-ff](../01-merge-ff/README.md): 조상 관계가 단순하면 포인터만 이동합니다.
- [06-rebase](../06-rebase/README.md): 갈라진 이력을 merge commit 없이 다시 일렬로 놓는 접근입니다.

## 질문 거리

1. merge commit이 있는 그래프는 어떤 장점이 있을까요?
2. fast-forward와 merge commit 중 무엇이 팀 이력을 더 잘 드러낼까요?
3. merge commit은 왜 부모가 두 개인가요?
