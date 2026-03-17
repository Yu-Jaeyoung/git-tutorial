# worktree

한 줄 요약: 브랜치를 왔다 갔다 하지 않고도 같은 저장소를 여러 작업 디렉터리에서 동시에 열 수 있게 해 주는 기능입니다.

- 비교 시나리오: [04-stash](../04-stash/README.md)

## 언제 쓰는가

- feature 작업을 유지한 채, `main`에서 급한 hotfix를 병행해야 할 때
- 브랜치 전환이 현재 작업 맥락을 자꾸 깨뜨릴 때

## 시작 상태 만들기

```bash
./bin/reset-lab worktree
git lg
```

## 실습 절차

먼저 hotfix용 보조 worktree를 만듭니다.

```bash
mkdir -p ../git-workshop-worktrees
git worktree add ../git-workshop-worktrees/hotfix-typo -b hotfix/typo main
git worktree list
```

보조 worktree에서 hotfix를 진행합니다.

```bash
cd ../git-workshop-worktrees/hotfix-typo
printf '\n- typo fix shipped from hotfix branch\n' >> README.md
git commit -am "Fix typo notice from hotfix worktree"
```

원래 작업 디렉터리로 돌아와 feature 작업을 계속합니다.

```bash
cd -
git switch feature/login
printf '\nLOGIN_COPY=ready-for-qa\n' >> app.txt
git commit -am "Refine login copy in main worktree"
git lg
```

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- worktree 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- `git worktree list`를 보면 하나의 저장소가 여러 작업 디렉터리로 열려 있습니다.
- hotfix용 디렉터리와 원래 디렉터리가 서로 다른 branch를 동시에 checkout할 수 있습니다.
- 브랜치 전환 때문에 현재 작업을 숨길 필요가 없습니다.

## 핵심 개념

- worktree는 저장소의 object database를 공유하면서, checkout 상태만 분리해 주는 기능입니다.
- “지금 일하던 맥락”과 “급한 다른 일”을 둘 다 온전히 보존할 수 있습니다.

## 자주 헷갈리는 포인트

- worktree는 repo를 통째로 복사하는 것이 아닙니다.
- 같은 branch를 두 worktree에서 동시에 checkout하는 데는 제약이 있습니다.
- 실습 후 정리가 필요하면 `git worktree remove`를 사용합니다.

## 비교 대상

- [04-stash](../04-stash/README.md): 잠깐 치워두는 정도면 stash가 간단하지만, 병렬 작업이면 worktree가 더 자연스럽습니다.

## 질문 거리

1. 왜 hotfix 상황에서는 stash보다 worktree가 더 깔끔할 수 있을까요?
2. worktree를 쓰면 브랜치 전환 비용이 어떻게 달라질까요?
3. worktree는 로컬 협업 흐름을 어떻게 바꿔 줄까요?
