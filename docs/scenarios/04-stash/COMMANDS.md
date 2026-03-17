# stash commands

- `printf '\nLOGIN_REVIEW=team-alpha\n' >> config.txt`: tracked 파일에 임시 변경을 만듭니다.
- `printf '\n- draft login QA checklist\n' >> docs/guide.md`: 두 번째 tracked 파일 변경을 만듭니다.
- `touch notes.txt`: untracked 파일을 만듭니다.
- `git stash push -u -m "login WIP before main review"`: 현재 작업 상태를 stash 합니다. `-u`는 untracked 파일 포함, `-m`은 stash 설명 메시지입니다.
- `git stash list`: 저장된 stash 목록을 확인합니다.
- `git switch main`: 잠깐 다른 브랜치로 이동합니다.
- `git switch feature/login`: 원래 작업 브랜치로 돌아옵니다.
- `git stash apply stash@{0}`: 가장 최근 stash를 복원하되 목록에서는 지우지 않습니다.
- `git reset --hard`: tracked 파일 변경을 현재 commit 상태로 되돌립니다.
- `git clean -fd`: untracked 파일과 디렉터리를 지웁니다. `-f`는 강제 실행, `-d`는 디렉터리까지 포함입니다.
- `git stash push -m "tiny follow-up"`: 이번에는 tracked 변경만 stash 합니다.
- `git stash pop`: stash를 복원하고, 성공하면 stash 목록에서 제거합니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
