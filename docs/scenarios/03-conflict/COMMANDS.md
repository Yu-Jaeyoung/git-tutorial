# conflict commands

- `git switch main`: merge를 실행할 기준 브랜치를 `main`으로 맞춥니다.
- `git merge feature/login`: 같은 줄을 양쪽 브랜치에서 다르게 바꿨기 때문에 conflict가 발생합니다.
- `git add config.txt`: 충돌 해결 후 `config.txt`가 해결됐다고 Git에 알립니다.
- `git commit -m "Resolve login rollout conflict"`: 충돌 해결 결과를 새 commit으로 기록합니다.
- `git merge --abort`: 진행 중인 merge를 중단하고 merge 시작 전 상태로 되돌립니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
