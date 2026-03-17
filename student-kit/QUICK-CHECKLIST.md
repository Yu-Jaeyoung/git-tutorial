# Quick Checklist

학생용 빠른 실습 카드입니다. 교사용 시나리오 문서와 같은 순서, 같은 명령 흐름을 기준으로 정리했습니다. 각 단계는 `시작 상태 만들기 -> 명령 실행 -> 그래프와 상태 확인` 순서로 진행합니다.

## 01 merge-ff

목표: fast-forward merge에서는 merge commit 없이 브랜치 포인터만 앞으로 이동한다는 점을 확인합니다.

```bash
./bin/reset-lab merge-ff
git lg
git switch main
git merge feature/login
git lg
git status -sb
```

체크:
- `main`만 앞으로 이동했는가
- merge commit이 새로 생기지 않았는가
- `main`과 `feature/login`이 같은 commit을 가리키는가

## 02 merge-commit

목표: 양쪽 브랜치가 각각 진행된 상태에서는 merge commit이 생긴다는 점을 확인합니다.

```bash
./bin/reset-lab merge-commit
git lg
git switch main
git merge feature/login
git lg
git status -sb
```

체크:
- merge 전에는 두 브랜치가 갈라져 있는가
- merge 뒤에 새 commit 하나가 생겼는가
- 왜 fast-forward가 불가능했는지 설명할 수 있는가

## 03 conflict

목표: 같은 줄을 서로 다르게 고친 뒤 충돌을 읽고 해결합니다.

```bash
./bin/reset-lab conflict
git lg
git switch main
git merge feature/login
git status -sb
```

그다음 `config.txt`를 직접 수정해서 원하는 결과로 정리한 뒤 아래를 실행합니다.

```bash
git add config.txt
git commit -m "Resolve login rollout conflict"
git lg
```

중단 복구를 따로 보고 싶다면 다시 시작 상태를 맞춘 뒤 아래도 해 봅니다.

```bash
git merge --abort
```

체크:
- conflict marker가 왜 생겼는가
- 충돌 해결 뒤 `git add`가 왜 필요한가
- merge가 실패한 것이 아니라 “대기 상태”였다는 점을 이해했는가

## 04 stash

목표: commit하지 않은 변경을 잠시 치워 두고 다시 복원합니다.

```bash
./bin/reset-lab stash
printf '\nLOGIN_REVIEW=team-alpha\n' >> config.txt
printf '\n- draft login QA checklist\n' >> docs/guide.md
touch notes.txt
git status -sb
```

먼저 `apply`를 확인합니다.

```bash
git stash push -u -m "login WIP before main review"
git stash list
git switch main
git switch feature/login
git stash apply stash@{0}
git status -sb
git stash list
```

다음으로 `pop`을 확인합니다.

```bash
git reset --hard
git clean -fd
printf '\nTEMP_NOTE=remove_me\n' >> app.txt
git stash push -m "tiny follow-up"
git stash pop
git status -sb
git stash list
```

체크:
- `-u`가 없으면 `notes.txt`는 어떻게 되는가
- `apply` 뒤에도 stash 항목이 남아 있는가
- `pop` 뒤에는 stash 항목이 사라지는가
- `stash`가 commit이 아니라 임시 보관이라는 점이 보이는가

## 05 worktree

목표: 브랜치 전환 없이 다른 디렉터리에서 병렬 작업합니다.

```bash
./bin/reset-lab worktree
git lg
git worktree list
mkdir -p ../git-workshop-worktrees
git worktree add ../git-workshop-worktrees/hotfix-typo -b hotfix/typo main
git worktree list
```

새 worktree에서 hotfix를 진행합니다.

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

마지막에는 보조 worktree를 정리합니다.

```bash
git worktree list
git worktree remove ../git-workshop-worktrees/hotfix-typo
git worktree list
```

체크:
- 같은 저장소를 두 디렉터리에서 보고 있는가
- hotfix용 디렉터리와 원래 디렉터리가 다른 브랜치를 동시에 checkout하고 있는가
- `git worktree list` 전후를 비교했을 때 목록이 어떻게 달라지는가
- `git worktree remove` 뒤에 보조 디렉터리와 등록 정보가 함께 정리되었는가
- `stash` 대신 `worktree`를 쓰는 게 더 좋은 상황을 말할 수 있는가

## 06 rebase

목표: feature branch를 최신 `main` 위로 다시 올리면서 commit hash가 바뀌는 점을 확인합니다.

기본 rebase:

```bash
./bin/reset-lab rebase
git lg
git switch feature/payment
git rebase main
git lg
git status -sb
```

같은 주제에서 충돌과 `--abort`도 바로 이어서 확인합니다.

```bash
./bin/reset-lab rebase-conflict
git lg
git switch feature/payment
git rebase main
git status -sb
git rebase --abort
git lg
git status -sb
```

체크:
- 내용은 비슷해도 feature commit hash가 바뀌었는가
- 그래프가 선형으로 정리되었는가
- 충돌이 났을 때 `git rebase --abort`로 원래 그래프로 돌아왔는가
- 이 작업이 “commit을 다시 쓰는 것”이라는 말을 설명할 수 있는가

## 07 interactive-rebase

목표: 여러 commit을 의미 있는 단위로 정리합니다.

```bash
./bin/reset-lab interactive-rebase
git lg
git switch feature/payment
git rebase -i main
git lg
```

편집기 안에서는 아래 기준으로 바꿔 봅니다.

- `pick`: `draft payment copy`
- `reword`: `wip payment validation`
- `squash`: `typo in payment validation`
- `fixup`: `remove debug log`
- `drop`: `obsolete sandbox note`

체크:
- 어떤 commit을 합쳤는가
- commit 메시지가 더 읽기 좋아졌는가
- 왜 보통 “공유하기 전 로컬 브랜치”에서만 이 작업을 하는지 설명할 수 있는가

심화 1: `edit`와 `--abort`

다시 시작 상태를 맞춘 뒤 첫 줄을 `edit`로 바꿔 rebase를 멈춰 봅니다.

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git rebase -i main
git status -sb
git lg
git rebase --abort
git lg
```

심화 2: merge commit이 있는 상태 비교

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git switch -c spike/payment-helper HEAD~3
printf '\nMERGE_HELPER_NOTE=yes\n' >> README.md
git commit -am "Add payment helper note from spike"
git switch feature/payment
printf '\nPAYMENT_COPY_PASS=yes\n' >> config.txt
git commit -am "Note payment copy pass on feature"
git merge --no-ff spike/payment-helper -m "Merge payment helper branch"
git lg
git rev-parse --short HEAD
git rev-parse --short HEAD^
git rev-parse --short HEAD^2
git rev-parse --short HEAD~1
git rev-parse --short HEAD~2
```

여기서 확인할 것:
- `HEAD^2`는 merge commit일 때만 의미가 있는가
- `HEAD~2`는 first-parent 기준으로 계산되는가
- 같은 `HEAD~2`를 기준으로 할 때 기본 `git rebase -i HEAD~2`와 `git rebase -i --rebase-merges HEAD~2`의 todo가 다르게 보일 수 있다는 점을 이해했는가

심화 3: 완료된 interactive rebase를 reflog로 복구

이 실습은 “진행 중이면 `--abort`, 이미 끝났으면 `reflog + reset`”을 구분하는 드릴입니다.

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git rebase -i main
git lg
git reflog show feature/payment --oneline -n 10
git branch backup/after-interactive-rebase
git reset --hard <rebase 전 커밋 해시>
git lg
```

여기서 확인할 것:
- 완료된 interactive rebase 뒤에는 `git rebase --abort`가 아니라 `reflog`를 봐야 하는가
- `reset` 수업의 reflog 복구와 같은 패턴이 적용되는가
- 현재 rewrite 결과를 남기고 싶다면 왜 백업 브랜치를 먼저 만드는가

## 08 cherry-pick

목표: 브랜치 전체가 아니라 특정 commit만 선택해서 가져옵니다.

```bash
./bin/reset-lab cherry-pick
git lg
git log --oneline hotfix/typo
git switch main
git cherry-pick <commit-hash>
git lg
git status -sb
```

체크:
- 전체 hotfix branch를 합치지 않고 commit 하나만 가져왔는가
- 새로 들어온 commit은 기존과 내용은 같지만 hash는 다른가
- 왜 merge보다 cherry-pick이 더 적합한 상황인지 말할 수 있는가

## 09 revert

목표: 이미 남아 있는 commit을 지우지 않고, 되돌리는 새 commit을 만듭니다.

```bash
./bin/reset-lab revert
git lg
git switch main
git revert --no-edit HEAD
git lg
git status -sb
```

체크:
- 원래 잘못된 commit은 여전히 history에 남아 있는가
- 되돌리는 새 commit이 추가되었는가
- 왜 협업 브랜치에서는 `reset`보다 `revert`가 안전한가

## 10 reset

목표: `--soft`, `--mixed`, `--hard` 차이와 `reflog` 복구를 확인합니다.

먼저 `--soft`를 해 봅니다.

```bash
./bin/reset-lab reset
git lg
git reset --soft HEAD~1
git status -sb
```

다시 시작 상태를 맞춘 뒤 `--mixed`를 해 봅니다.

```bash
./bin/reset-lab reset
git lg
git reset HEAD~1
git status -sb
```

다시 시작 상태를 맞춘 뒤 `--hard`와 `reflog`를 확인합니다.

```bash
./bin/reset-lab reset
git lg
git reset --hard HEAD~1
git status -sb
git reflog --oneline -n 5
```

그다음 `reflog`에서 `Add rollback drill note` commit hash를 찾아 복구합니다.

```bash
git reset --hard <commit-hash>
git lg
```

같은 원리는 완료된 `interactive rebase` 복구에도 그대로 적용됩니다. 즉, `reflog`는 `reset --hard`만 위한 도구가 아니라 “로컬 히스토리 재작성 전체의 안전망”이라고 이해하면 좋습니다.

체크:
- `--soft`는 무엇을 남기고 무엇만 되돌렸는가
- `--mixed`는 staging 상태를 어떻게 바꾸는가
- `--hard`는 working tree까지 어떻게 바꾸는가
- `reflog`에서 사라진 commit 흔적을 다시 찾을 수 있는가
