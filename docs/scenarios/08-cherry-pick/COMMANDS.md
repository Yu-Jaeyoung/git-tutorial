# cherry-pick commands

- `git log --oneline hotfix/typo`: `hotfix/typo` 브랜치 commit 목록을 한 줄씩 확인합니다.
- `git switch main`: commit을 가져올 대상 브랜치를 `main`으로 맞춥니다.
- `git cherry-pick <commit-hash>`: 특정 commit의 변경만 현재 브랜치에 적용합니다.
- `git cherry-pick --abort`: cherry-pick 도중 conflict가 나서 중단하고 싶을 때 시작 전 상태로 되돌립니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
