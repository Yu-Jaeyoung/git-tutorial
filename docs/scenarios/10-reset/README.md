# reset

한 줄 요약: `reset`은 branch 포인터를 뒤로 옮기면서 index와 working tree를 어디까지 되돌릴지 선택하는 로컬 정리 도구입니다.

- 수업 흐름: [Session 2 Lab](../../session-2-lab.md)
- 비교 시나리오: [09-revert](../09-revert/README.md)

## 언제 쓰는가

- 로컬에서 최근 commit을 다시 정리하고 싶을 때
- commit은 없애되 파일 변경은 남기거나, staging만 풀거나, 아예 작업 내용까지 버릴지 선택해야 할 때

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

## 명령과 옵션 풀이

- `./bin/reset-lab reset`: reset 실습용 기준 상태를 만듭니다.
- `git lg`: reset 전후로 어떤 commit이 보이는지 그래프로 확인합니다.
- `git reset --soft HEAD~1`: `reset`은 branch 기준점을 옮기는 명령이고, `--soft`는 index와 working tree는 그대로 둔 채 commit 위치만 한 단계 뒤로 보냅니다. `HEAD~1`은 현재 commit의 바로 이전 부모 commit입니다.
- `git status -sb`: soft, mixed, hard 결과를 가장 빨리 비교할 수 있는 상태 확인 명령입니다. `-s`는 short, `-b`는 branch입니다.
- `git reset HEAD~1`: 옵션을 쓰지 않으면 기본값은 `--mixed`입니다. commit 위치를 한 단계 뒤로 보내고, staging은 해제하지만 working tree 변경은 남깁니다.
- `git reset --hard HEAD~1`: `--hard`는 branch, index, working tree를 모두 대상 commit 상태로 맞춥니다. 가장 강한 되돌리기입니다.
- `git reflog --oneline -n 5`: `reflog`는 로컬에서 `HEAD`가 어떻게 이동했는지 기록합니다. `--oneline`은 한 줄 요약, `-n 5`는 최근 5개만 보겠다는 뜻입니다.
- `git reset --hard <reflog에서 찾은 "Add rollback drill note" 커밋 해시>`: reflog에서 찾은 실제 commit hash로 다시 hard reset해 잃어버린 commit 위치를 복구합니다. 꺾쇠 괄호 안은 예시이므로 직접 hash로 바꿔야 합니다.

## 관찰 포인트

- `--soft`, `--mixed`, `--hard`는 모두 `HEAD` 이동은 같고, index와 working tree 처리 범위만 다릅니다.
- `git reset HEAD~1`은 `--mixed`와 같습니다.
- `reflog`에는 최근 `HEAD` 이동 기록이 남아 있어서 로컬에서 잃어버린 commit을 찾는 데 도움이 됩니다.

## 핵심 개념

- reset은 로컬 히스토리를 재정렬하는 데 강력하지만, 공유된 브랜치에서는 위험합니다.
- 특히 `--hard`는 working tree까지 버리므로 가장 조심해야 합니다.

## 자주 헷갈리는 포인트

- reset과 revert는 둘 다 “되돌리기”지만, reset은 히스토리 자체를 바꾸고 revert는 새 commit을 쌓습니다.
- `git clean -fd`는 untracked 파일과 디렉터리를 지우는 명령이지 reset 옵션이 아닙니다.
- `reflog`는 로컬 기록이므로 마지막 안전망으로 함께 가르치는 것이 좋습니다.

## 비교 대상

- [09-revert](../09-revert/README.md): 공유된 히스토리를 보존한 채 실수를 취소합니다.

## 질문 거리

1. `--soft`, `--mixed`, `--hard`의 차이를 index와 working tree 기준으로 설명할 수 있나요?
2. 왜 `reset --hard`는 특히 공유된 브랜치에서 위험할까요?
3. `reflog`는 왜 reset 수업에서 반드시 함께 다루는 편이 좋을까요?
