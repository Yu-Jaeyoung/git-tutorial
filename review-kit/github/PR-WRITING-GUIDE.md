# PR Writing Guide

PR 본문은 리뷰어가 변경 내용을 빠르게 이해하고 확인할 수 있게 돕는 짧은 안내문입니다.

## When to use

- feature PR
- hotfix PR
- draft PR
- 작은 문서 변경 PR

이번 복습용 PR 예시는 [REVIEW-PR-EXAMPLES.md](./REVIEW-PR-EXAMPLES.md)에 따로 정리했습니다.

## Recommended sections

아래 세 섹션을 기본 틀로 사용하면 대부분의 PR을 무리 없이 설명할 수 있습니다.

### What changed

- 어떤 파일이나 동작이 바뀌었는지
- 리뷰어가 알아야 할 최종 값이나 중요한 문자열이 무엇인지

### Git choice

- 왜 이 branch 전략이나 Git 선택이 자연스러웠는지
- 특별한 Git 판단이 없으면 한 줄만 써도 충분합니다
- 예:
  - feature branch로 분리
  - draft PR 유지
  - hotfix 먼저 반영
  - `merge` 또는 `rebase` 선택 이유

### What to check

- 리뷰어가 무엇을 확인하면 되는지
- 예:
  - 최종 문자열이 맞는가
  - 불필요한 파일이 포함되지 않았는가
  - 의도한 branch 흐름이 유지되었는가

## Writing tips

- 한 섹션당 1~3개 bullet이면 충분합니다.
- 상세 명령어 로그를 PR 본문에 그대로 붙이지 않습니다.
- issue 본문을 반복하기보다, 실제 변경 결과를 요약합니다.
- exact value가 중요할 때만 문자열을 직접 적습니다.

## Generic example

```md
## What changed

- update the release note text in `docs/release-checklist.md`
- add a review flag to `config.txt`

## Git choice

- keep the work on a feature branch and open a PR before merging to `main`

## What to check

- the final text matches the requested value
- no unrelated files were included
```
