# tag commands

- `git tag --list 'release/*'`: 이 실습에서 만든 release 태그만 필터링해서 봅니다. 내부 `scenario/*` 태그와 섞이지 않게 해 줍니다.
- `git tag release/v1.0.0 HEAD~1`: `HEAD~1` commit에 lightweight tag를 붙입니다.
- `git tag -a release/v1.1.0 -m "Release v1.1.0" HEAD`: 현재 commit에 annotated tag를 붙입니다. `-a`는 annotated tag, `-m`은 tag 메시지입니다.
- `git show --no-patch <tag>`: tag가 가리키는 대상과 tag 메타데이터를 봅니다. `--no-patch`는 diff 출력은 생략한다는 뜻입니다.
- `git rev-parse --short <tag>`: tag가 실제로 어떤 commit hash를 가리키는지 짧게 확인합니다.
- `git switch --detach <tag>`: tag가 가리키는 commit을 detached HEAD 상태로 checkout합니다.
- `git tag -d <tag>`: local tag 이름표를 삭제합니다. commit 자체는 남아 있습니다.
- `git push origin <tag>`: 특정 tag 하나만 remote로 보냅니다.
- `git push origin --tags`: local tag를 한꺼번에 remote로 보냅니다.
- `git push --delete origin <tag>`: remote tag를 삭제합니다.

공통 명령과 표기는 [command-reference](../reference/README.md)를 참고합니다.
