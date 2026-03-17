# Quick Checklist

학생용 빠른 실습 카드입니다. 각 단계는 `시작 상태 만들기 -> 명령 실행 -> 그래프와 상태 확인` 순서로 진행합니다.

## 01 merge-ff

목표: fast-forward merge에서는 merge commit 없이 브랜치 포인터만 앞으로 이동한다는 점을 확인합니다.

```bash
./bin/reset-lab merge-ff
git status -sb
git lg
git merge feature/login
git lg
```

체크:
- `main`만 앞으로 이동했는가
- merge commit이 새로 생기지 않았는가
- `main`과 `feature/login`이 같은 commit을 가리키는가

## 02 merge-commit

목표: 양쪽 브랜치가 각각 진행된 상태에서는 merge commit이 생긴다는 점을 확인합니다.

```bash
./bin/reset-lab merge-commit
git status -sb
git lg
git merge feature/login
git lg
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
git merge feature/login
git status -sb
sed -n '1,20p' config.txt
```

그다음 `config.txt`를 직접 수정해서 원하는 결과로 정리한 뒤 아래를 실행합니다.

```bash
git add config.txt
git commit
git lg
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
git stash push -u -m "login WIP before main review"
git stash list
git status -sb
git switch main
git switch feature/login
git stash apply stash@{0}
git status -sb
```

체크:
- `-u`가 없으면 `notes.txt`는 어떻게 되는가
- `apply` 뒤에도 stash 항목이 남아 있는가
- `stash`가 commit이 아니라 임시 보관이라는 점이 보이는가

## 05 worktree

목표: 브랜치 전환 없이 다른 디렉터리에서 병렬 작업합니다.

```bash
./bin/reset-lab worktree
git worktree list
git worktree add ../git-workshop-worktrees/main-hotfix main
git worktree list
```

새 worktree에서 hotfix commit을 하나 만들어 봅니다.

```bash
cd ../git-workshop-worktrees/main-hotfix
printf '\nHOTFIX_READY=yes\n' >> config.txt
git add config.txt
git commit -m "Add hotfix marker on main"
cd -
git lg
```

체크:
- 같은 저장소를 두 디렉터리에서 보고 있는가
- 현재 디렉터리를 바꾸지 않고도 `main`을 수정할 수 있었는가
- `stash` 대신 `worktree`를 쓰는 게 더 좋은 상황을 말할 수 있는가

## 06 rebase

목표: feature branch를 최신 `main` 위로 다시 올리면서 commit hash가 바뀌는 점을 확인합니다.

```bash
./bin/reset-lab rebase
git lg
git rebase main
git lg
```

체크:
- 내용은 비슷해도 feature commit hash가 바뀌었는가
- 그래프가 선형으로 정리되었는가
- 이 작업이 “commit을 다시 쓰는 것”이라는 말을 설명할 수 있는가

## 07 rebase-conflict

목표: rebase 도중 충돌을 내고 `git rebase --abort`로 원래 상태로 돌아옵니다.

```bash
./bin/reset-lab rebase-conflict
git lg
git rebase main
git status -sb
git rebase --abort
git lg
```

체크:
- 어떤 파일에서 충돌이 났는가
- `--abort` 뒤에 원래 그래프로 돌아왔는가
- 충돌 해결 후 계속 진행하려면 어떤 명령이 필요한지 말할 수 있는가

## 08 interactive-rebase

목표: 여러 commit을 의미 있는 단위로 정리합니다.

```bash
./bin/reset-lab interactive-rebase
git lg
git rebase -i HEAD~5
git lg
```

편집기 안에서는 `pick`, `reword`, `squash`, `fixup`, `drop`을 바꿔 보세요.

체크:
- 어떤 commit을 합쳤는가
- commit 메시지가 더 읽기 좋아졌는가
- 왜 보통 “공유하기 전 로컬 브랜치”에서만 이 작업을 하는지 설명할 수 있는가

## 09 cherry-pick

목표: 브랜치 전체가 아니라 특정 commit만 선택해서 가져옵니다.

```bash
./bin/reset-lab cherry-pick
git lg
git log --oneline hotfix/typo
git cherry-pick <commit-hash>
git lg
```

체크:
- 전체 hotfix branch를 합치지 않고 commit 하나만 가져왔는가
- 새로 들어온 commit은 기존과 내용은 같지만 hash는 다른가
- 왜 merge보다 cherry-pick이 더 적합한 상황인지 말할 수 있는가

## 10 revert

목표: 이미 남아 있는 commit을 지우지 않고, 되돌리는 새 commit을 만듭니다.

```bash
./bin/reset-lab revert
git lg
git revert HEAD --no-edit
git lg
```

체크:
- 원래 잘못된 commit은 여전히 history에 남아 있는가
- 되돌리는 새 commit이 추가되었는가
- 왜 협업 브랜치에서는 `reset`보다 `revert`가 안전한가

## 11 reset

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
git reset HEAD~1
git status -sb
```

다시 시작 상태를 맞춘 뒤 `--hard`와 `reflog`를 확인합니다.

```bash
./bin/reset-lab reset
git reset --hard HEAD~1
git status -sb
git reflog --oneline
```

체크:
- `--soft`는 무엇을 남기고 무엇만 되돌렸는가
- `--mixed`는 staging 상태를 어떻게 바꾸는가
- `--hard`는 working tree까지 어떻게 바꾸는가
- `reflog`에서 사라진 commit 흔적을 다시 찾을 수 있는가
