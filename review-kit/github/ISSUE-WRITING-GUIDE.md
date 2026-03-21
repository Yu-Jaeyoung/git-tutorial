# Issue Writing Guide

GitHub issue는 바로 실행할 수 있는 작업 지시서 형태로 작성하는 것이 좋습니다.

## What an issue should contain

아래 정보는 issue 본문에 반드시 들어가야 합니다.

- 어떤 branch를 써야 하는가
- 어떤 파일을 수정해야 하는가
- 어떤 줄이나 값을 어떻게 바꿔야 하는가
- 완료 조건이 무엇인가

예를 들면 아래 수준까지는 보여주는 편이 좋습니다.

- before: `- customer notice: draft`
- after: `- customer notice: draft login notice`

또는

- `README.md` 맨 아래에 `- release intro ready for review` 추가

## What not to put in the issue body

아래 내용은 issue 본문보다 다른 문서에 두는 편이 좋습니다.

- 상세 명령어
- Git 선택 이유에 대한 긴 해설
- 예시 풀이 전체

이런 내용은 `QUICK-FLOW.md` 또는 `HINTS-AND-SOLUTION.md`가 더 잘 맞습니다.

## Current examples in this kit

- [issue-1.md](./issue-1.md): fast-forward 가능한 기능 작업을 지시하는 예시
- [issue-2.md](./issue-2.md): `stash`를 포함한 draft 작업 예시
- [issue-3.md](./issue-3.md): `worktree`, hotfix, merge, conflict를 함께 다루는 예시

## Quick checklist

issue를 쓰기 전에 아래를 확인합니다.

- branch 이름이 명확한가
- 수정 파일이 빠지지 않았는가
- before/after 값 또는 정확한 추가 문자열이 있는가
- “Done when”이 눈에 보이는 상태로 작성되어 있는가
