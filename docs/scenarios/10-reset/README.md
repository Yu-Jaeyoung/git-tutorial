# reset

한 줄 요약: `reset`은 branch 포인터를 뒤로 옮기면서 index와 working tree를 어디까지 되돌릴지 선택하는 로컬 정리 도구입니다.

- 비교 시나리오: [09-revert](../09-revert/README.md), [07-interactive-rebase](../07-interactive-rebase/README.md)

## 언제 쓰는가

- 로컬에서 최근 commit을 다시 정리하고 싶을 때
- commit은 없애되 파일 변경은 남기거나, staging만 풀거나, 아예 작업 내용까지 버릴지 선택해야 할 때
- 이미 끝난 `rebase`나 `interactive rebase` 결과를 이전 상태로 되돌리고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab reset
git lg
```

## 실습 절차

### 1. `--soft`

```bash
git reset --soft HEAD~1
git status -sb
```

관찰:

- branch는 한 commit 뒤로 갑니다.
- 변경사항은 staging area에 남아 있습니다.

### 2. `--mixed`

다시 초기화합니다.

```bash
./bin/reset-lab reset
```

이제 기본값인 mixed를 봅니다.

```bash
git reset HEAD~1
git status -sb
```

관찰:

- branch는 한 commit 뒤로 갑니다.
- 변경사항은 working tree에 남고, staging은 해제됩니다.

### 3. `--hard`

다시 초기화합니다.

```bash
./bin/reset-lab reset
```

가장 강한 reset을 실행합니다.

```bash
git reset --hard HEAD~1
git status -sb
git reflog --oneline -n 5
```

이제 `reflog`로 잃어버린 commit을 되찾습니다.

```bash
git reset --hard <reflog에서 찾은 "Add rollback drill note" 커밋 해시>
git lg
```

### 4. `interactive rebase` 복구와 연결해 보기

이번에는 `reset` 시나리오가 아니라 `interactive rebase` 시나리오를 이용해, `reflog`가 단순히 `reset --hard` 복구용이 아니라 rewrite 복구에도 쓰인다는 점을 확인합니다.

먼저 `interactive rebase`를 완료합니다.

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git rebase -i main
git lg
```

편집기에서는 아래처럼 정리하면 됩니다.

- `pick`: `draft payment copy`
- `reword`: `wip payment validation`
- `squash`: `typo in payment validation`
- `fixup`: `remove debug log`
- `drop`: `obsolete sandbox note`

이제 `reflog`를 확인합니다.

```bash
git reflog show feature/payment --oneline -n 10
```

브랜치 reflog를 보면 보통 `feature/payment`가 rebase되기 전 가리키던 commit이 더 직접적으로 보입니다. 현재 상태를 보존하고 싶다면 먼저 백업 브랜치를 하나 만듭니다.

```bash
git branch backup/after-interactive-rebase
```

그다음 `reflog`에서 찾은 rebase 전 commit으로 돌아갑니다.

```bash
git reset --hard <reflog에서 찾은 rebase 전 커밋 해시>
git lg
```

관찰:

- 완료된 `interactive rebase`는 `git rebase --abort`로는 되돌릴 수 없습니다.
- 대신 `reflog`가 rebase 전 `HEAD` 이동 기록을 남겨 두기 때문에, `reset --hard`로 원래 브랜치 상태를 복구할 수 있습니다.
- 이 패턴은 merge commit이 interactive rebase 과정에서 사라진 경우에도 같은 원리로 적용됩니다.

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- reset 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- `--soft`, `--mixed`, `--hard`는 모두 `HEAD` 이동은 같고, index와 working tree 처리 범위만 다릅니다.
- `git reset HEAD~1`은 `--mixed`와 같습니다.
- `reflog`에는 최근 `HEAD` 이동 기록이 남아 있어서 로컬에서 잃어버린 commit을 찾는 데 도움이 됩니다.
- `reflog`는 `reset --hard` 이후뿐 아니라 완료된 `interactive rebase` 복구에도 그대로 사용할 수 있습니다.

## 핵심 개념

- reset은 로컬 히스토리를 재정렬하는 데 강력하지만, 공유된 브랜치에서는 위험합니다.
- 특히 `--hard`는 working tree까지 버리므로 가장 조심해야 합니다.
- `reflog + reset` 조합은 “완료된 히스토리 재작성”을 되돌리는 마지막 안전망이라는 점이 중요합니다.

## 자주 헷갈리는 포인트

- reset과 revert는 둘 다 “되돌리기”지만, reset은 히스토리 자체를 바꾸고 revert는 새 commit을 쌓습니다.
- `git clean -fd`는 untracked 파일과 디렉터리를 지우는 명령이지 reset 옵션이 아닙니다.
- `reflog`는 로컬 기록이므로 마지막 안전망으로 함께 가르치는 것이 좋습니다.
- rebase가 아직 진행 중이면 먼저 `git rebase --abort`를 생각해야 하고, 이미 끝난 뒤라면 그때는 `reflog + reset`이 더 적절합니다.

## 비교 대상

- [09-revert](../09-revert/README.md): 공유된 히스토리를 보존한 채 실수를 취소합니다.
- [07-interactive-rebase](../07-interactive-rebase/README.md): 완료된 history rewrite를 reflog로 복구하는 대표 사례입니다.

## 질문 거리

1. `--soft`, `--mixed`, `--hard`의 차이를 index와 working tree 기준으로 설명할 수 있나요?
2. 왜 `reset --hard`는 특히 공유된 브랜치에서 위험할까요?
3. `reflog`는 왜 reset 수업에서 반드시 함께 다루는 편이 좋을까요?
4. 진행 중인 rebase를 되돌릴 때와, 이미 끝난 interactive rebase를 되돌릴 때는 왜 명령이 달라질까요?
