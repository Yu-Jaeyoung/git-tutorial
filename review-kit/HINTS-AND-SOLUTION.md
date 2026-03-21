# Hints And Solution

막혔을 때만 참고하는 예시 풀이입니다.  
반드시 이 순서대로만 해야 하는 것은 아니지만, 현재 `review-kit`의 starter 파일과 issue 문안을 기준으로 하면 아래 흐름이 가장 자연스럽습니다.

## 0. 시작 준비

새 GitHub repo를 만든 뒤 `starter-repo/` 내용을 복사하고 baseline commit을 만듭니다.

```bash
git add .
git commit -m "Prepare review project baseline"
git push -u origin main
```

그다음 `github/issue-1.md`, `github/issue-2.md`, `github/issue-3.md`를 참고해 issue 3개를 생성합니다.

## 1. Issue 1 예시 풀이

branch: `feature/release-intro`

```bash
git switch -c feature/release-intro
```

수정:

- `README.md` 맨 아래에 `- release intro ready for review` 추가
- `docs/release-checklist.md`의 `release owner`를 자기 이름으로 수정

commit과 push:

```bash
git add .
git commit -m "Add release intro for review"
git push -u origin feature/release-intro
```

로컬 fast-forward 확인:

```bash
git branch verify/ff-issue-1 main
git switch verify/ff-issue-1
git merge --ff-only feature/release-intro
git log --graph --decorate --oneline --all
git switch main
git branch -D verify/ff-issue-1
```

이후 GitHub에서 `feature/release-intro -> main` PR을 만들고 merge합니다.  
PR 본문은 일반 원칙을 `github/PR-WRITING-GUIDE.md`에서 보고, 실습 예시는 `github/REVIEW-PR-EXAMPLES.md`의 `Issue 1 example`을 참고합니다.

merge 뒤 로컬 동기화:

```bash
git switch main
git pull origin main
```

## 2. Issue 2 예시 풀이

branch: `feature/login-notice`

```bash
git switch -c feature/login-notice
printf '\nNOTICE_REVIEW=team-alpha\n' >> config.txt
touch notes.txt
git status -sb
```

그다음 `docs/release-checklist.md`를 열어 아래처럼 직접 수정합니다.

```text
- customer notice: draft login notice
```

stash 복습:

```bash
git stash push -u -m "issue-2 draft before review"
git switch main
git switch feature/login-notice
git stash pop
git status -sb
```

commit과 draft PR:

```bash
git add docs/release-checklist.md config.txt
git commit -m "Draft login notice update"
git push -u origin feature/login-notice
```

GitHub에서 `feature/login-notice -> main` draft PR을 만듭니다. 이 PR은 아직 merge하지 않습니다.  
PR 본문은 일반 원칙을 `github/PR-WRITING-GUIDE.md`에서 보고, 실습 예시는 `github/REVIEW-PR-EXAMPLES.md`의 `Issue 2 example`을 참고합니다.

## 3. Issue 3 예시 풀이

먼저 현재 feature branch에서 미완성 작업을 하나 더 만듭니다.

```bash
printf '\nLOGIN_STATUS=in-progress\n' >> app.txt
git status -sb
git worktree list
mkdir -p ../git-review-worktrees
git worktree add ../git-review-worktrees/hotfix-notice -b hotfix/notice-typo main
git worktree list
```

새 worktree에서 hotfix 진행:

```bash
cd ../git-review-worktrees/hotfix-notice
printf '\n- hotfix typo shipped from main\n' >> README.md
```

그다음 `docs/release-checklist.md`를 열어 아래 값으로 직접 수정합니다.

```text
- customer notice: typo fixed on main
```

이후 commit과 push를 진행합니다.

```bash
git add README.md docs/release-checklist.md
git commit -m "Fix customer notice typo on main"
git push -u origin hotfix/notice-typo
```

GitHub에서 `hotfix/notice-typo -> main` PR을 만들고 먼저 merge합니다.  
PR 본문은 일반 원칙을 `github/PR-WRITING-GUIDE.md`에서 보고, 실습 예시는 `github/REVIEW-PR-EXAMPLES.md`의 `Issue 3 hotfix example`을 참고합니다.

원래 작업 디렉터리로 복귀:

```bash
cd -
git status -sb
git add app.txt
git commit -m "Continue login notice review"
git fetch origin
git merge origin/main
git status -sb
```

`docs/release-checklist.md`의 conflict를 아래 값으로 정리합니다.

```text
- customer notice: draft login notice after typo fix
```

마무리:

```bash
git add docs/release-checklist.md
git commit -m "Merge main into login notice review"
git push
git log --graph --decorate --oneline --all
git worktree list
git worktree remove ../git-review-worktrees/hotfix-notice
git worktree list
```

GitHub에서 기존 `feature/login-notice -> main` PR 본문을 업데이트하고 merge합니다.  
최종 PR 본문은 일반 원칙을 `github/PR-WRITING-GUIDE.md`에서 보고, 실습 예시는 `github/REVIEW-PR-EXAMPLES.md`의 `Issue 3 feature example`을 참고합니다.
