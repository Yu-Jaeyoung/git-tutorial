# worktree

한 줄 요약: 브랜치를 왔다 갔다 하지 않고도 같은 저장소를 여러 작업 디렉터리에서 동시에 열 수 있게 해 주는 기능입니다.

- 수업 흐름: [Session 1 Lab](../../session-1-lab.md)
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

## 명령과 옵션 풀이

- `./bin/reset-lab worktree`: worktree 실습 시작 상태로 복원합니다.
- `git lg`: 현재 브랜치 그래프를 요약해서 보여줍니다.
- `mkdir -p ../git-workshop-worktrees`: `mkdir`는 디렉터리를 만들고, `-p`는 부모 디렉터리가 없어도 함께 만들며 이미 있어도 오류를 내지 않습니다. `..`는 부모 디렉터리를 뜻합니다.
- `git worktree add ../git-workshop-worktrees/hotfix-typo -b hotfix/typo main`: `worktree add`는 새 작업 디렉터리를 만듭니다. 첫 인자는 새 디렉터리 경로, `-b hotfix/typo`는 새 브랜치 생성, `main`은 그 브랜치가 출발할 기준 commit입니다.
- `git worktree list`: 현재 연결된 worktree 목록을 보여줍니다.
- `cd ../git-workshop-worktrees/hotfix-typo`: 새 worktree 디렉터리로 이동합니다.
- `printf '\n- typo fix shipped from hotfix branch\n' >> README.md`: `printf`는 문자열 출력, `\n`은 줄바꿈, `>>`는 파일 끝에 이어 쓰기입니다.
- `git commit -am "Fix typo notice from hotfix worktree"`: `-a`는 이미 추적 중인 수정 파일을 자동으로 stage하고, `-m`은 commit 메시지를 바로 적습니다. untracked 파일은 `-a`만으로 포함되지 않습니다.
- `cd -`: 바로 직전에 있던 디렉터리로 돌아갑니다.
- `git switch feature/login`: 원래 메인 작업 디렉터리에서 feature 브랜치를 계속 봅니다.
- `git commit -am "Refine login copy in main worktree"`: 위와 같은 이유로 tracked 파일 수정은 `-am` 조합으로 바로 commit할 수 있습니다.

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
