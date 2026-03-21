# GitHub Review Kit

`01`부터 `05`까지 학습한 `merge-ff`, `merge-commit`, `conflict`, `stash`, `worktree`를 1시간 안에 GitHub 프로젝트 흐름으로 복습하기 위한 학생용 패키지입니다.

이 패키지는 로컬 `reset-lab` 복습용인 `student-kit/`와 다릅니다. 이번에는 각자 자신의 GitHub repository에서 아래 흐름을 직접 밟습니다.

- GitHub issue 작성
- 작업 branch 생성
- 로컬 작업
- PR 생성
- PR merge

## 들어 있는 파일

- `QUICK-FLOW.md`: 먼저 스스로 풀어 보는 문제지형 진행 카드
- `HINTS-AND-SOLUTION.md`: 막혔을 때만 보는 예시 풀이
- `starter-repo/`: 새 GitHub repo를 시작할 때 복사할 초기 파일 세트
- `github/issue-*.md`: GitHub issue 본문 예시
- `github/ISSUE-WRITING-GUIDE.md`: issue에는 어떤 정보가 들어가야 하는지 설명하는 공통 가이드
- `github/PR-WRITING-GUIDE.md`: 일반적인 PR 본문 작성 원칙을 설명하는 공통 가이드
- `github/REVIEW-PR-EXAMPLES.md`: 이번 복습 실습에서 참고할 PR 본문 예시 모음

## 준비물

- GitHub 계정
- 새 repository를 만들 수 있는 권한
- Git이 설치된 로컬 환경
- 이 `review-kit/` 폴더

## 시작 방법

1. GitHub에서 새 빈 repository를 하나 만듭니다.
   - 추천 이름: `git-review-01-05`
2. 로컬로 clone 합니다.
3. 이 폴더의 `starter-repo/` 안 파일을 새 repo 루트에 복사합니다.
4. 초기 commit을 하나 만든 뒤 `main`에 push 합니다.
5. `github/issue-1.md`, `github/issue-2.md`, `github/issue-3.md`를 참고해 issue 3개를 생성합니다.
6. issue를 쓸 때는 `github/ISSUE-WRITING-GUIDE.md`를 함께 참고합니다.
7. PR을 열 때는 `github/PR-WRITING-GUIDE.md`의 공통 틀을 보고, 이번 실습용 예시는 `github/REVIEW-PR-EXAMPLES.md`를 참고합니다.
8. 먼저 `QUICK-FLOW.md`만 보고 진행합니다.
9. 정말 막히는 경우에만 `HINTS-AND-SOLUTION.md`를 참고합니다.

초기 baseline commit은 아래처럼 만들면 됩니다.

```bash
git add .
git commit -m "Prepare review project baseline"
git push -u origin main
```

## 1시간 진행 순서

- 0~10분: 새 repo 준비, starter 파일 복사, initial commit, issue 3개 생성
- 10~20분: Issue 1 수행, fast-forward 가능 상태 확인, PR merge
- 20~35분: Issue 2 수행, `stash` 실습, draft PR 생성
- 35~55분: Issue 3 수행, `worktree` hotfix, `main` merge, conflict 해결, 최종 PR merge
- 55~60분: 마지막 질문으로 복습 정리

## Issue 흐름 요약

### Issue 1. Release intro 추가

- branch: `feature/release-intro`
- 목표:
  - fast-forward 가능한 상태를 만든다
  - 실제 반영은 GitHub PR로 한다
- 핵심 파일:
  - `README.md`
  - `docs/release-checklist.md`

### Issue 2. Login notice 초안 작성

- branch: `feature/login-notice`
- 목표:
  - tracked + untracked 변경을 만든다
  - `git stash push -u`와 `git stash pop`을 복습한다
  - PR은 열되 merge하지 않고 유지한다
- 핵심 파일:
  - `docs/release-checklist.md`
  - `config.txt`
  - `notes.txt`

### Issue 3. 긴급 hotfix 처리

- hotfix branch: `hotfix/notice-typo`
- 기준 feature branch: `feature/login-notice`
- 목표:
  - 현재 feature 작업을 유지한 채 `worktree`로 hotfix를 병렬 처리한다
  - hotfix를 먼저 `main`에 반영한다
  - 이후 feature branch에서 `git merge origin/main`을 하며 merge commit과 conflict를 함께 본다
- 핵심 파일:
  - `docs/release-checklist.md`
  - `README.md`
  - `app.txt`

## 꼭 지킬 규칙

- GitHub PR merge 방식은 기본 `merge commit`으로 통일합니다.
- fast-forward는 GitHub PR 결과로 설명하지 않고, 로컬에서 `git merge --ff-only`로만 확인합니다.
- `Issue 2`의 PR은 바로 merge하지 않습니다.
- `Issue 3`의 hotfix PR을 먼저 merge한 뒤, 기존 `feature/login-notice` PR을 업데이트합니다.
- `Issue 3`에서 conflict는 `docs/release-checklist.md`의 같은 줄을 양쪽에서 다르게 수정했기 때문에 발생해야 합니다.

## 제출물

- issue 3개 링크
- PR 3개 링크
  - `Issue 1` PR
  - `Issue 2/3` feature PR
  - `Issue 3` hotfix PR
- 마지막 `git log --graph --decorate --oneline --all` 확인 결과
- 아래 질문에 대한 자기 설명

## 마지막 QA

1. 왜 `Issue 1`은 fast-forward 가능한 상태였나요?
2. 왜 `Issue 2`는 `stash`, `Issue 3`는 `worktree`가 더 자연스러웠나요?
3. 왜 마지막에는 merge commit과 conflict가 함께 생겼나요?

## 참고

- 먼저 [QUICK-FLOW.md](./QUICK-FLOW.md)로 문제를 풉니다.
- 막히면 [HINTS-AND-SOLUTION.md](./HINTS-AND-SOLUTION.md)를 참고합니다.
- GitHub issue 예시와 작성 원칙, PR 작성 가이드는 `github/` 폴더를 봅니다.
- 이 패키지는 `01~05` 복습 전용입니다. `rebase`, `revert`, `reset`, 협업 capstone은 포함하지 않습니다.

## Issue/PR 문안 읽는 법

- `issue-*.md`는 실제 GitHub issue 본문 예시입니다.
- issue에는 어떤 정보가 들어가야 하는지에 대한 공통 원칙은 [github/ISSUE-WRITING-GUIDE.md](./github/ISSUE-WRITING-GUIDE.md)에 정리했습니다.
- PR 본문의 일반 원칙은 [github/PR-WRITING-GUIDE.md](./github/PR-WRITING-GUIDE.md)에 정리했습니다.
- 이번 복습 실습에서 바로 참고할 PR 예시는 [github/REVIEW-PR-EXAMPLES.md](./github/REVIEW-PR-EXAMPLES.md)에 정리했습니다.
