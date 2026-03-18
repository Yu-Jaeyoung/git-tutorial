# github-collab commands

- `git clone <repo-url>`: GitHub 원격 저장소를 로컬로 복제합니다.
- `git switch -c feature/a-login-copy`: 학생 A용 작업 브랜치를 만듭니다.
- `git switch -c feature/b-release-note`: 학생 B용 작업 브랜치를 만듭니다.
- `git add .`: 현재 변경 파일을 staging area에 올립니다.
- `git commit -m "Update login copy for release"`: 학생 A의 변경을 commit 합니다.
- `git commit -m "Prepare release note update"`: 학생 B의 변경을 commit 합니다.
- `git push -u origin <branch>`: 로컬 브랜치를 처음 remote에 올리고 upstream을 연결합니다.
- `git branch demo/b-release-note-rebase`: stale 상태를 보존한 비교용 branch를 같은 commit 위치에 하나 더 만듭니다.
- `git fetch origin`: remote 최신 상태를 가져오되 현재 branch는 그대로 둡니다.
- `git merge origin/main`: remote `main`을 현재 branch에 병합합니다. 이번 capstone의 conflict 유도 지점입니다.
- `git rebase origin/main`: 현재 branch commit들을 최신 `origin/main` 뒤로 다시 적용합니다.
- `git add docs/release-checklist.md`: conflict를 해결한 파일을 stage 합니다.
- `git rebase --continue`: rebase 중 conflict를 해결한 뒤 다음 단계로 진행합니다.
- `git push`: conflict 해결 commit을 remote branch에 반영합니다.
- `git push --force-with-lease origin <branch>`: rebase처럼 history rewrite 뒤에도 remote를 덮어쓸 수 있지만, 원격이 예상과 다를 때는 중단합니다.
- `git log --graph --decorate --oneline --all`: `git lg` alias가 없는 실제 GitHub 저장소에서 그래프를 확인할 때 씁니다.
- `git revert -m 1 <merge-commit-hash>`: GitHub 기본 merge commit으로 들어간 PR을 mainline 기준으로 되돌립니다.
- `git merge --no-ff demo/merge-helper -m "Merge helper branch for history demo"`: merge commit이 있는 branch를 일부러 만들어 interactive rebase 비교에 씁니다.
- `git rebase -i HEAD~2`: 최근 두 단계의 first-parent 구간을 interactive rebase 대상으로 엽니다. merge commit이 포함되면 기본값에서는 평평해질 수 있습니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
