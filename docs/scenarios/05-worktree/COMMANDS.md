# worktree commands

- `printf '\nLOGIN_COPY=draft-in-progress\n' >> app.txt`: 현재 worktree에서 진행 중인 feature 수정을 만듭니다.
- `printf '\n- note while login work is in progress\n' >> docs/guide.md`: 두 번째 tracked 파일에도 미완성 작업 흔적을 남깁니다.
- `git worktree list`: 현재 연결된 worktree 목록을 확인합니다. 작업 디렉터리 경로, 현재 checkout된 branch, HEAD를 함께 읽을 수 있습니다.
- `mkdir -p ../git-workshop-worktrees`: worktree를 둘 디렉터리를 만듭니다.
- `git worktree add ../git-workshop-worktrees/hotfix-typo -b hotfix/typo main`: `main`에서 출발하는 새 브랜치 `hotfix/typo`와 그 worktree를 함께 만듭니다. `-b`는 worktree 생성과 동시에 새 브랜치를 만든다는 뜻입니다.
- `git worktree add <path> main`: 기존 `main` 브랜치를 바로 checkout한 worktree를 만듭니다. 새 브랜치가 꼭 필요하지 않을 때 씁니다.
- `cd ../git-workshop-worktrees/hotfix-typo`: 새 worktree 디렉터리로 이동합니다.
- `printf '\n- typo fix shipped from hotfix branch\n' >> README.md`: hotfix용 수정 내용을 만듭니다.
- `git commit -am "Fix typo notice from hotfix worktree"`: tracked 파일 수정만 빠르게 commit 합니다. `-a`는 자동 stage, `-m`은 메시지 지정입니다.
- `git commit -am "Continue login work after hotfix"`: 원래 디렉터리에서 작업 중이던 tracked 변경을 hotfix 뒤에 이어서 commit 합니다.
- `git worktree remove <path>`: 정리된 상태의 worktree를 제거합니다. 등록 정보와 디렉터리를 함께 지웁니다.
- `git worktree add ../git-workshop-worktrees/hotfix-typo hotfix/typo`: `hotfix/typo` 브랜치가 남아 있다면 같은 worktree를 다시 엽니다. `remove`로 디렉터리를 지운 뒤 복구 예시로 쓸 수 있습니다.
- `git worktree remove --force <path>`: 미커밋 변경이나 잠긴 상태가 있어도 강제로 제거합니다. 내용 손실 위험이 있으니 신중하게 씁니다.
- `git worktree prune`: 이미 사라진 worktree의 메타데이터 흔적을 정리합니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
