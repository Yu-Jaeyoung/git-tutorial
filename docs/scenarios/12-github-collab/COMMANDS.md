# github-collab commands

- `git clone <repo-url>`: GitHub 원격 저장소를 로컬로 복제합니다.
- `git switch -c feature/a-login-copy`: 학생 A용 작업 브랜치를 만듭니다.
- `git switch -c feature/b-release-note`: 학생 B용 작업 브랜치를 만듭니다.
- `git add .`: 현재 변경 파일을 staging area에 올립니다.
- `git commit -m "Update login copy for release"`: 학생 A의 변경을 commit 합니다.
- `git commit -m "Prepare release note update"`: 학생 B의 변경을 commit 합니다.
- `git push -u origin <branch>`: 로컬 브랜치를 처음 remote에 올리고 upstream을 연결합니다.
- `git fetch origin`: remote 최신 상태를 가져오되 현재 branch는 그대로 둡니다.
- `git merge origin/main`: remote `main`을 현재 branch에 병합합니다. 이번 capstone의 conflict 유도 지점입니다.
- `git add docs/release-checklist.md`: conflict를 해결한 파일을 stage 합니다.
- `git push`: conflict 해결 commit을 remote branch에 반영합니다.
- `git log --graph --decorate --oneline --all`: `git lg` alias가 없는 실제 GitHub 저장소에서 그래프를 확인할 때 씁니다.
- `git revert <commit-hash>`: 공유 브랜치에서 잘못 반영된 commit을 취소하는 새 commit을 만듭니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
