# interactive-rebase commands

## Git Commands

- `git switch feature/payment`: 정리할 commit들이 있는 브랜치로 이동합니다.
- `git rebase -i main`: `main`을 기준으로 interactive rebase를 시작합니다.
- `git rebase -i --rebase-merges main`: merge 구조를 가능한 한 보존하면서 interactive rebase를 시작합니다.
- `git rebase --abort`: 진행 중인 interactive rebase를 취소합니다.
- `git reflog show feature/payment --oneline -n 10`: 완료된 interactive rebase를 되돌릴 때 rebase 전 `feature/payment` tip을 찾습니다.
- `git branch backup/after-interactive-rebase`: 현재 rewrite 결과를 잃고 싶지 않을 때 임시 백업 브랜치를 만듭니다.
- `git reset --hard <reflog에서 찾은 rebase 전 커밋 해시>`: reflog에서 찾은 rebase 전 상태로 돌아갑니다.
- `git switch -c spike/payment-helper HEAD~3`: merge commit 실습을 위한 보조 브랜치를 만듭니다.
- `git merge --no-ff spike/payment-helper -m "Merge payment helper branch"`: fast-forward가 가능해도 merge commit을 강제로 남겨 merge 구조 예시를 만듭니다.
- `git rev-parse --short HEAD^2`: 현재 merge commit의 두 번째 부모를 짧은 hash로 확인합니다.

## Rebase Todo Keywords

- `pick`: 해당 commit을 rebase 결과에 포함합니다. 일반 commit은 새 기준점 위에 다시 적용되므로 hash는 바뀔 수 있습니다.
- `reword`: 내용은 그대로 두고 commit 메시지만 수정합니다.
- `edit`: 해당 commit에서 멈춰 amend나 추가 수정을 하게 해 줍니다.
- `squash`: 현재 commit을 바로 위 commit과 합치고 메시지도 함께 정리합니다.
- `fixup`: 현재 commit을 바로 위 commit과 합치되 현재 commit 메시지는 버립니다.
- `drop`: 해당 commit을 현재 브랜치 히스토리에서 제외합니다.
- `label`: 현재 위치에 이름표를 붙입니다. `--rebase-merges`에서 자주 보입니다.
- `reset`: 이전에 붙여 둔 label 위치로 HEAD를 되돌립니다.
- `merge`: 지정한 label을 현재 위치와 다시 합쳐 merge commit을 재구성합니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
