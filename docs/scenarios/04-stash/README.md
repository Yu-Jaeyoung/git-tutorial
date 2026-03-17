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

## 명령과 옵션 풀이

- `./bin/reset-lab stash`: stash 실습용 시작 상태를 만듭니다.
- `git status -sb`: `-s`는 짧은 형식, `-b`는 브랜치 정보를 함께 보여줍니다.
- `printf '\nLOGIN_REVIEW=team-alpha\n' >> config.txt`: `printf`는 문자열을 정확히 출력합니다. `\n`은 줄바꿈, `>>`는 파일 끝에 덧붙여 쓰기입니다.
- `touch notes.txt`: 파일이 없으면 새로 만들고, 있으면 수정 시각만 갱신합니다.
- `git stash push -u -m "login WIP before main review"`: `stash push`는 현재 작업 상태를 임시 보관합니다. `-u`는 untracked 파일까지 포함, `-m`은 stash 설명 메시지입니다.
- `git stash list`: 저장된 stash 목록을 확인합니다.
- `git switch main`: 현재 브랜치를 `main`으로 바꿉니다.
- `git switch feature/login`: 다시 원래 작업 브랜치로 돌아옵니다.
- `git stash apply stash@{0}`: `apply`는 stash를 복원하되 목록에서는 지우지 않습니다. `stash@{0}`은 가장 최근 stash를 뜻합니다.
- `git reset --hard`: `reset`은 기준 commit으로 되돌리는 명령이고, `--hard`는 branch, index, working tree까지 모두 해당 commit 상태로 맞춥니다.
- `git clean -fd`: `clean`은 추적되지 않는 파일을 지웁니다. `-f`는 강제 실행, `-d`는 디렉터리까지 함께 삭제입니다.
- `git stash push -m "tiny follow-up"`: 여기서는 untracked 파일이 없으므로 `-u` 없이 tracked 변경만 stash 합니다.
- `git stash pop`: stash를 복원하고, 성공하면 stash 목록에서 제거합니다.

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
