# revert

한 줄 요약: 이미 기록된 commit을 지우지 않고, 그 반대 내용을 가진 새 commit을 만들어 안전하게 취소하는 방식입니다.

- 수업 흐름: [Session 2 Lab](../../session-2-lab.md)
- 비교 시나리오: [10-reset](../10-reset/README.md)

## 언제 쓰는가

- 원격에 공유된 잘못된 commit을 취소해야 할 때
- 협업 브랜치의 히스토리를 보존하면서 실수만 되돌리고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab revert
git lg
```

## 실습 절차

```bash
git switch main
git revert --no-edit HEAD
git lg
git status -sb
```

## 명령과 옵션 풀이

- `./bin/reset-lab revert`: revert 실습용 기준 상태로 되돌립니다.
- `git lg`: revert 전후 그래프를 비교합니다.
- `git switch main`: 취소할 commit이 있는 브랜치로 이동합니다.
- `git revert --no-edit HEAD`: `revert`는 지정한 commit의 반대 내용을 새 commit으로 만듭니다. `--no-edit`는 Git이 제안하는 기본 revert 메시지를 그대로 사용하겠다는 뜻이고, `HEAD`는 현재 commit을 뜻합니다.
- `git status -sb`: revert 후 working tree가 깨끗한지와 현재 브랜치를 확인합니다.

## 관찰 포인트

- 기존 잘못된 commit은 그래프에 그대로 남아 있습니다.
- 그 뒤에 “이전 변경을 취소하는” 새 revert commit이 추가됩니다.
- working tree는 다시 깨끗한 상태로 돌아옵니다.

## 핵심 개념

- revert는 히스토리를 지우지 않습니다. 대신 “반대 방향의 commit”을 하나 더 쌓습니다.
- 그래서 공유된 브랜치에서 가장 안전한 취소 방법으로 쓰입니다.

## 자주 헷갈리는 포인트

- revert는 commit을 없애는 명령이 아닙니다.
- 되돌리는 대상 commit이 복잡하면 revert 도중 conflict가 날 수도 있습니다.
- “공유된 히스토리는 revert”라는 규칙을 반복해서 익히는 편이 좋습니다.

## 비교 대상

- [10-reset](../10-reset/README.md): 로컬에서 브랜치 포인터를 뒤로 움직이며 히스토리를 바꿉니다.

## 질문 거리

1. revert는 왜 협업 브랜치에서 안전하다고 말할 수 있을까요?
2. revert와 reset은 둘 다 “되돌리기”인데 무엇이 다를까요?
3. 어떤 경우에는 revert commit이 또 다른 리뷰 포인트가 될까요?
