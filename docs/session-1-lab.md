# Session 1 Lab

## 진행 원칙

- 모든 파트 시작 전에 `git lg`를 먼저 보여줍니다.
- `git lg`는 수업용으로 현재 브랜치만 보여주고, 시나리오 태그까지 볼 일이 있을 때만 `git lga`를 씁니다.
- 학습자가 먼저 결과를 예측하게 한 뒤 명령을 실행합니다.
- 실습이 끝나면 `한 문장 규칙`으로 정리합니다.
- 시나리오별 상세 설명은 [Scenario Index](scenarios/README.md) 아래 순서형 폴더 문서를 참고합니다.

## 0. 내부 모델 워밍업

```bash
git status -sb
git lg
```

설명 포인트:

- commit은 스냅샷이다.
- branch는 commit을 가리키는 이름표다.
- `HEAD`는 현재 내가 서 있는 위치다.
- working tree와 index는 commit 이전 상태를 관리한다.

## 1. Fast-forward merge

상세 설명: [01-merge-ff](scenarios/01-merge-ff/README.md)

초기화:

```bash
./bin/reset-lab merge-ff
git lg
```

예측 질문:

- `main`에 새 커밋이 없으면 merge 결과는 어떻게 생길까?

실습:

```bash
git switch main
git merge feature/login
git lg
```

디브리프:

- merge commit 없이 branch 포인터만 앞으로 이동한다.
- `main`이 `feature/login`의 조상일 때 fast-forward가 가능하다.

한 문장 규칙:

- `main`에 새 작업이 없으면 merge는 단순히 포인터 이동일 수 있다.

## 2. Merge commit

상세 설명: [02-merge-commit](scenarios/02-merge-commit/README.md)

초기화:

```bash
./bin/reset-lab merge-commit
git lg
```

예측 질문:

- 두 브랜치가 서로 다른 커밋을 가지면 Git은 어떤 commit을 만들까?

실습:

```bash
git switch main
git merge feature/login
git lg
```

디브리프:

- 공통 조상 이후 양쪽 이력이 모두 살아 있으면 merge commit이 생성된다.
- merge commit은 “둘 다 포함한다”는 기록이다.

한 문장 규칙:

- 두 줄기 이력이 이미 갈라졌다면 merge는 새로운 결합 commit을 만든다.

## 3. Conflict 해결

상세 설명: [03-conflict](scenarios/03-conflict/README.md)

초기화:

```bash
./bin/reset-lab conflict
git lg
```

예측 질문:

- 같은 줄을 양쪽에서 수정했으면 Git이 자동으로 결정할 수 있을까?

실습:

```bash
git switch main
git merge feature/login
git status -sb
```

`config.txt`를 열어 conflict marker를 읽고 원하는 최종 값으로 직접 수정합니다.

마무리:

```bash
git add config.txt
git commit -m "Resolve login rollout conflict"
git lg
```

복구 명령도 함께 소개:

```bash
git merge --abort
```

한 문장 규칙:

- 충돌은 실패가 아니라 “사람의 결정이 필요한 대기 상태”다.

## 4. Stash

상세 설명: [04-stash](scenarios/04-stash/README.md)

초기화:

```bash
./bin/reset-lab stash
git status -sb
```

준비:

```bash
printf '\nLOGIN_REVIEW=team-alpha\n' >> config.txt
printf '\n- draft login QA checklist\n' >> docs/guide.md
touch notes.txt
git status -sb
```

실습 1: `apply`

```bash
git stash push -u -m "login WIP before main review"
git stash list
git switch main
git switch feature/login
git stash apply stash@{0}
git status -sb
git stash list
```

실습 2: `pop`

```bash
git reset --hard
git clean -fd
printf '\nTEMP_NOTE=remove_me\n' >> app.txt
git stash push -m "tiny follow-up"
git stash pop
git status -sb
```

정리 포인트:

- `apply`는 stash를 남기고 복원한다.
- `pop`은 복원 후 stash를 제거한다.
- `-u`를 쓰면 untracked 파일도 함께 보관할 수 있다.

한 문장 규칙:

- 커밋할 준비는 안 됐지만 작업을 잠시 치워야 할 때 `stash`를 쓴다.

## 5. Worktree

상세 설명: [05-worktree](scenarios/05-worktree/README.md)

초기화:

```bash
./bin/reset-lab worktree
git lg
```

실습:

```bash
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

원래 작업 디렉터리로 돌아와 feature 작업을 이어갑니다.

```bash
cd -
git switch feature/login
printf '\nLOGIN_COPY=ready-for-qa\n' >> app.txt
git commit -am "Refine login copy in main worktree"
git lg
```

정리 포인트:

- 브랜치를 바꾸지 않고도 서로 다른 작업 디렉터리를 동시에 유지할 수 있다.
- hotfix와 feature를 병렬로 진행할 때 특히 강력하다.

한 문장 규칙:

- 브랜치 전환이 작업 맥락을 깨뜨릴 때 `worktree`가 가장 깔끔하다.
