# worktree commands

- `mkdir -p ../git-workshop-worktrees`: worktree를 둘 디렉터리를 만듭니다.
- `git worktree add ../git-workshop-worktrees/hotfix-typo -b hotfix/typo main`: `main`에서 출발하는 새 브랜치 `hotfix/typo`와 그 worktree를 함께 만듭니다.
- `git worktree list`: 현재 연결된 worktree 목록을 확인합니다.
- `cd ../git-workshop-worktrees/hotfix-typo`: 새 worktree 디렉터리로 이동합니다.
- `printf '\n- typo fix shipped from hotfix branch\n' >> README.md`: hotfix용 수정 내용을 만듭니다.
- `git commit -am "Fix typo notice from hotfix worktree"`: tracked 파일 수정만 빠르게 commit 합니다. `-a`는 자동 stage, `-m`은 메시지 지정입니다.
- `git switch feature/login`: 원래 worktree에서 feature 브랜치 작업을 이어갑니다.
- `git commit -am "Refine login copy in main worktree"`: 원래 디렉터리에서 feature 작업을 commit 합니다.
- `git worktree remove <path>`: 실습 후 보조 worktree를 정리할 때 씁니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
