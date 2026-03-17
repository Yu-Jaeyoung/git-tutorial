# command-reference

한 줄 요약: 여러 시나리오에서 반복되는 공통 명령과 revision 표기, 자주 쓰는 쉘 표현을 한곳에 모아 둔 참고 문서입니다.

## 언제 읽는가

- 여러 시나리오에서 같은 설명이 반복되는 느낌이 들 때
- `git lg`, `git status -sb`, `HEAD~1`, `stash@{0}` 같은 표기가 헷갈릴 때
- 시나리오별 `COMMANDS.md`에서 공통 설명을 생략한 부분을 채워 읽고 싶을 때

## 공통 Git 명령

- `./bin/reset-lab <scenario>`: 실습 저장소 안에서 특정 시나리오 시작 상태로 복원합니다. `<scenario>`에는 `merge-ff`, `stash`, `rebase` 같은 실제 시나리오 이름이 들어갑니다.
- `git lg`: 실습 저장소에 미리 등록된 alias입니다. 현재 수업용 브랜치 그래프를 짧고 읽기 쉽게 보여줍니다.
- `git lga`: 숨겨진 시나리오 태그까지 포함해 전체 ref 그래프를 봅니다. 태그나 숨은 참조까지 확인할 때 씁니다.
- `git status -sb`: 현재 브랜치와 working tree 상태를 짧게 보여줍니다. `-s`는 short, `-b`는 branch입니다.
- `git switch <branch>`: 작업 브랜치를 바꿉니다. `<branch>`에는 `main`, `feature/login` 같은 브랜치 이름이 들어갑니다.
- `git log --oneline <branch>`: 특정 브랜치의 commit 목록을 한 줄씩 확인합니다.
- `git reflog --oneline -n <N>`: `HEAD`가 최근에 어떻게 움직였는지 요약해서 봅니다.
- `git reflog show <branch> --oneline -n <N>`: 특정 브랜치가 최근 어떤 commit들을 가리켰는지 봅니다.
- `git branch <name>`: 현재 commit에 새 브랜치를 만듭니다. 임시 백업 브랜치를 만들 때 자주 씁니다.
- `git rev-parse --short <revision>`: Git revision 표기를 실제 짧은 hash로 풀어 보여줍니다.

## 자주 쓰는 revision 표기

- `HEAD`: 현재 내가 서 있는 commit
- `HEAD~1`: 현재 commit의 첫 번째 부모
- `HEAD~2`: 첫 번째 부모 체인을 두 번 따라간 commit
- `HEAD^` 또는 `HEAD^1`: 현재 commit의 첫 번째 부모
- `HEAD^2`: 현재 commit이 merge commit일 때 두 번째 부모
- `<commit-hash>`: 실제 commit hash 자리표시자
- `stash@{0}`: 가장 최근 stash

## 자주 쓰는 쉘 표현

- `printf '...\n' >> file`: 문자열을 파일 끝에 덧붙여 씁니다. `\n`은 줄바꿈입니다.
- `touch file`: 파일이 없으면 새로 만들고, 있으면 수정 시각만 갱신합니다.
- `mkdir -p path`: 중간 디렉터리가 없어도 함께 만듭니다. 이미 있어도 오류를 내지 않습니다.
- `cd -`: 바로 직전에 있던 디렉터리로 돌아갑니다.

## 읽는 법

- 공통 명령은 이 문서에서 한 번 읽고, 각 시나리오에서는 그 시나리오에만 필요한 명령을 봅니다.
- 시나리오별 세부 옵션과 예시는 각 폴더의 `COMMANDS.md`에 정리되어 있습니다.
