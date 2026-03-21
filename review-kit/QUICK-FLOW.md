# Quick Flow

1시간 복습용 문제지형 진행 카드입니다. 먼저 이 문서만 보고 스스로 진행해 보세요.  
막히는 경우에만 [HINTS-AND-SOLUTION.md](./HINTS-AND-SOLUTION.md)를 참고합니다.

## 0. 시작 준비

- 새 GitHub repo를 만든다
- `starter-repo/` 내용을 repo 루트에 복사한다
- baseline commit을 만든 뒤 `main`에 push 한다
- `github/issue-1.md`, `github/issue-2.md`, `github/issue-3.md`를 참고해 issue 3개를 만든다

## 1. Issue 1

- branch: `feature/release-intro`
- 목표:
  - fast-forward 가능한 상태 만들기
  - 실제 반영은 GitHub PR merge로 마무리하기
- 수정 파일:
  - `README.md`
  - `docs/release-checklist.md`
- 정확한 추가 문장과 최종 값은 `github/issue-1.md`를 기준으로 합니다.
- 해야 할 일:
  - 릴리즈 소개 한 줄 추가
  - release owner 지정
  - 로컬에서 fast-forward 가능 상태를 확인
  - PR 생성 및 merge
- PR 본문:
  - 일반 원칙: `github/PR-WRITING-GUIDE.md`
  - 실습 예시: `github/REVIEW-PR-EXAMPLES.md`의 `Issue 1 example`
- 스스로 확인할 질문:
  - 왜 이 상태는 fast-forward 가능하다고 말할 수 있는가
  - 왜 GitHub PR merge 결과와 로컬 fast-forward는 완전히 같지 않은가

## 2. Issue 2

- branch: `feature/login-notice`
- 목표:
  - tracked + untracked 변경 만들기
  - `stash`로 draft 작업 잠깐 치우기
  - draft PR 열어 두기
- 수정 파일:
  - `docs/release-checklist.md`
  - `config.txt`
  - `notes.txt`
- 정확한 추가 문자열과 최종 값은 `github/issue-2.md`를 기준으로 합니다.
- 해야 할 일:
  - customer notice 초안 작성
  - review 설정 추가
  - untracked 메모 파일 생성
  - `stash push -u`와 `stash pop` 실행
  - draft PR 생성
- PR 본문:
  - 일반 원칙: `github/PR-WRITING-GUIDE.md`
  - 실습 예시: `github/REVIEW-PR-EXAMPLES.md`의 `Issue 2 example`
- 스스로 확인할 질문:
  - 왜 여기서는 commit보다 stash가 더 자연스러운가
  - `-u`가 없으면 어떤 파일이 빠지는가

## 3. Issue 3

- feature branch: `feature/login-notice`
- hotfix branch: `hotfix/notice-typo`
- 목표:
  - dirty 상태를 유지한 채 `worktree`로 hotfix 처리하기
  - hotfix를 먼저 `main`에 반영하기
  - 이후 feature branch에서 `main`을 merge하며 merge commit과 conflict를 함께 보기
- 수정 파일:
  - `app.txt`
  - `README.md`
  - `docs/release-checklist.md`
- 정확한 수정 값과 미완성 변경 내용은 `github/issue-3.md`를 기준으로 합니다.
- 해야 할 일:
  - feature branch에 미완성 변경 하나 만들기
  - `worktree add`, `worktree list`, `worktree remove` 사용하기
  - hotfix PR 먼저 merge하기
  - 기존 feature branch에서 `origin/main` 반영하기
  - `docs/release-checklist.md` conflict 해결하기
  - 기존 feature PR 업데이트 후 merge하기
- PR 본문:
  - 일반 원칙: `github/PR-WRITING-GUIDE.md`
  - hotfix PR 예시: `github/REVIEW-PR-EXAMPLES.md`의 `Issue 3 hotfix example`
  - feature PR 예시: `github/REVIEW-PR-EXAMPLES.md`의 `Issue 3 feature example`
- 스스로 확인할 질문:
  - 왜 여기서는 stash보다 worktree가 더 자연스러운가
  - 왜 마지막에는 merge commit과 conflict가 함께 생기는가

## 제출물

- issue 3개 링크
- PR 3개 링크
- 마지막 `git log --graph --decorate --oneline --all` 확인 결과

## 마지막 질문

1. 왜 `Issue 1`은 fast-forward 가능한 상태였나요?
2. 왜 `Issue 2`는 `stash`, `Issue 3`는 `worktree`가 더 자연스러웠나요?
3. 마지막 merge에서 conflict가 생긴 직접 원인은 무엇이었나요?
