# Assessment

## 수업 종료 기준

- 각 명령의 목적을 한 줄로 설명할 수 있다.
- `git lg`를 보고 현재 브랜치 구조를 말할 수 있다.
- `merge vs rebase`, `revert vs reset`, `stash vs worktree`를 상황에 맞게 구분할 수 있다.
- 최소 2번 이상 실패 후 복구를 경험했다.

## 수행 체크리스트

| 항목 | 확인 |
| --- | --- |
| fast-forward merge를 실행하고 설명할 수 있다 | ☐ |
| merge commit이 생기는 조건을 말할 수 있다 | ☐ |
| conflict marker를 읽고 수동 해결할 수 있다 | ☐ |
| `stash apply`와 `stash pop` 차이를 설명할 수 있다 | ☐ |
| `worktree`로 다른 브랜치를 동시에 열 수 있다 | ☐ |
| `rebase` 후 commit hash가 바뀐 이유를 말할 수 있다 | ☐ |
| `interactive rebase`로 커밋을 정리할 수 있다 | ☐ |
| 필요한 commit만 `cherry-pick`할 수 있다 | ☐ |
| 공유된 실수를 `revert`로 되돌릴 수 있다 | ☐ |
| `reset --soft`, `--mixed`, `--hard` 차이를 설명할 수 있다 | ☐ |
| `reflog`로 잃어버린 commit을 다시 찾을 수 있다 | ☐ |

## 구두 평가 질문

1. 왜 `merge`와 `rebase`를 서로 대체 가능한 명령으로만 보면 안 되나요?
2. `reset --hard`를 원격에 push한 브랜치에서 쓰면 왜 문제가 되나요?
3. `stash` 대신 `worktree`가 더 좋은 상황은 언제인가요?
4. `revert`가 commit을 “지우는” 것이 아니라는 말은 무슨 뜻인가요?
5. `interactive rebase`에서 `squash`와 `fixup` 차이는 무엇인가요?

## 강사용 판정 기준

- 합격: 상황 설명과 명령 선택 이유를 그래프 기준으로 말할 수 있다.
- 보완 필요: 명령 이름은 알지만 `왜 이 명령인지`를 설명하지 못한다.
- 재실습 권장: `reset`, `rebase`, `cherry-pick`에서 복구 경로를 모른다.
