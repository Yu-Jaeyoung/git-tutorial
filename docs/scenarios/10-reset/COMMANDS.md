# reset commands

- `git reset --soft HEAD~1`: commit 위치만 한 단계 뒤로 보내고 staging과 working tree는 그대로 둡니다.
- `git reset HEAD~1`: 기본 `--mixed` 동작입니다. commit 위치를 뒤로 보내고 staging은 해제하지만 working tree 변경은 남깁니다.
- `git reset --hard HEAD~1`: branch, index, working tree를 모두 대상 commit 상태로 맞춥니다.
- `git reflog --oneline -n 5`: 최근 `HEAD` 이동 기록을 봅니다.
- `git reset --hard <reflog에서 찾은 커밋 해시>`: reflog에서 찾은 위치로 강하게 되돌립니다.
- `git reflog show feature/payment --oneline -n 10`: 완료된 interactive rebase 전 `feature/payment` tip을 찾을 때 유용합니다.
- `git branch backup/after-interactive-rebase`: 현재 rewrite 결과를 잃고 싶지 않을 때 백업 브랜치를 만듭니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
