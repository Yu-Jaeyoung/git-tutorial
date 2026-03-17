# stash

한 줄 요약: 아직 commit하고 싶지 않은 변경사항을 잠깐 치워 두고 다른 작업으로 이동해야 할 때 `stash`를 씁니다.

- 비교 시나리오: [05-worktree](../05-worktree/README.md)

## 언제 쓰는가

- 작업 중이지만 아직 commit 메시지로 남길 만큼 정리되지 않았을 때
- 급히 다른 브랜치로 이동해야 하는데 working tree를 깨끗하게 만들고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab stash
git status -sb
```

## 실습 절차

먼저 tracked 파일과 untracked 파일을 섞어서 변경합니다.

```bash
printf '\nLOGIN_REVIEW=team-alpha\n' >> config.txt
printf '\n- draft login QA checklist\n' >> docs/guide.md
touch notes.txt
git status -sb
```

이제 `apply`를 보여줍니다.

```bash
git stash push -u -m "login WIP before main review"
git stash list
git switch main
git switch feature/login
git stash apply stash@{0}
git status -sb
git stash list
```

다음으로 `pop`을 보여줍니다.

```bash
git reset --hard
git clean -fd
printf '\nTEMP_NOTE=remove_me\n' >> app.txt
git stash push -m "tiny follow-up"
git stash pop
git status -sb
git stash list
```

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- stash 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- `git stash push -u` 직후 working tree가 깨끗해집니다.
- `-u`를 붙였기 때문에 `notes.txt` 같은 untracked 파일도 함께 사라집니다.
- `apply`는 stash 항목을 남기고 복원하고, `pop`은 복원 후 stash 목록에서 제거합니다.

## 핵심 개념

- stash는 branch 히스토리를 바꾸지 않고 working tree와 index 상태를 임시 보관합니다.
- “지금은 commit하기 애매하지만 잠시 옆으로 빼 두고 싶다”는 상황에 맞는 도구입니다.

## 자주 헷갈리는 포인트

- stash는 commit의 대체제가 아닙니다. 오래 쌓아두면 맥락을 잊기 쉽습니다.
- `-u`가 없으면 untracked 파일은 stash에 들어가지 않습니다.
- stash를 꺼낼 때도 충돌이 날 수 있습니다.

## 비교 대상

- [05-worktree](../05-worktree/README.md): 작업 맥락을 보존한 채 병렬로 일하려면 worktree가 더 낫습니다.

## 질문 거리

1. 왜 이 상황에서는 commit보다 stash가 더 자연스러울까요?
2. `apply`와 `pop`을 굳이 나눠 둔 이유는 무엇일까요?
3. `stash` 대신 `worktree`를 쓰면 더 좋은 상황은 언제일까요?
