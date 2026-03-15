# interactive-rebase

한 줄 요약: `rebase -i`는 commit 순서와 메시지, 묶음 방식을 직접 편집해 로컬 히스토리를 리뷰하기 좋은 형태로 정리하는 도구입니다.

- 수업 흐름: [Session 2 Lab](../../session-2-lab.md)
- 비교 시나리오: [06-rebase](../06-rebase/README.md)

## 언제 쓰는가

- PR을 올리기 전에 지저분한 로컬 commit을 정리하고 싶을 때
- 의미 없는 중간 commit, typo fix, debug 제거 같은 흔적을 합치고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab interactive-rebase
git lg
```

## 실습 절차

```bash
git switch feature/payment
git rebase -i main
```

편집기에서 아래 기준으로 정리합니다.

- `pick` 유지: `draft payment copy`
- `reword`: `wip payment validation`
- `squash`: `typo in payment validation`
- `fixup`: `remove debug log`
- `drop`: `obsolete sandbox note`

reword 시 권장 메시지:

```text
Add payment validation
```

마무리:

```bash
git lg
```

필요하면 중단 명령도 함께 보여줍니다.

```bash
git rebase --abort
```

## 명령과 옵션 풀이

- `./bin/reset-lab interactive-rebase`: interactive rebase 실습 상태를 다시 만듭니다.
- `git lg`: rebase 전후 commit 구조를 비교합니다.
- `git switch feature/payment`: 정리할 commit들이 있는 브랜치로 이동합니다.
- `git rebase -i main`: `rebase`는 commit을 다시 적용하고, `-i`는 interactive의 약자로 todo 목록을 편집할 수 있게 합니다. `main`은 현재 commit들을 다시 얹을 기준 브랜치입니다.
- `git rebase -i --rebase-merges main`: merge commit 구조까지 보존하면서 interactive rebase를 하고 싶을 때 씁니다. 기본 `rebase -i`와 달리 merge topology를 유지하려고 시도합니다.
- `git rebase --abort`: 편집 도중 꼬였거나 결과가 마음에 들지 않으면 rebase 자체를 취소합니다.

## rebase todo 명령 풀이

- `pick`: 해당 commit을 그대로 유지합니다.
- `reword`: 내용은 그대로 두고 commit 메시지만 수정합니다.
- `squash`: 현재 commit을 바로 위 commit과 합치고, 메시지도 함께 정리합니다.
- `fixup`: 현재 commit을 바로 위 commit과 합치되, 현재 commit 메시지는 버립니다.
- `drop`: 해당 commit을 현재 브랜치 히스토리에서 제외합니다.

## merge commit FAQ

### 왜 `git rebase -i main`을 하면 merge commit이 보이지 않나요?

- 기본 interactive rebase는 merge 구조를 보존하지 않고, 현재 브랜치를 “선형 commit 목록”으로 다시 만들려고 합니다.
- 그래서 todo 목록에는 보통 merge commit 자체가 아니라, 다시 적용할 일반 commit들만 보입니다.
- 이때 merge commit 안으로 들어왔던 다른 브랜치의 일반 commit들은 선형 목록에 나타날 수 있지만, merge commit 줄 자체는 기본값으로는 보이지 않습니다.
- merge commit까지 유지하며 다루고 싶다면 `git rebase -i --rebase-merges main`을 사용해야 합니다.

### 왜 interactive rebase를 하면 merge commit이 사라지나요?

- 기본 rebase는 새 기준 위에 commit을 다시 쌓는 과정에서 merge topology를 평평하게 펼칩니다.
- merge commit은 부모가 둘 이상인 특별한 commit인데, 기본 `rebase -i`는 그 구조를 기본값으로 재생성하지 않습니다.
- 그래서 결과 그래프가 더 직선형이 되면서 merge commit이 없어질 수 있습니다.

### merge commit이 사라졌다면 어떻게 되돌리나요?

- 아직 rebase 중이라면 가장 먼저 `git rebase --abort`를 시도합니다.
- 이미 rebase가 끝났다면 `git reflog`로 rebase 시작 전 `HEAD`를 찾고, `git reset --hard <이전 커밋>`으로 돌아가는 것이 가장 일반적입니다.
- 다음부터 merge commit을 보존하고 싶다면 `git rebase -i --rebase-merges main`을 사용합니다.

### merge commit이 삭제된 뒤 remote에 push가 되나요?

- 원격 브랜치가 이미 예전 merge commit을 가지고 있다면, 일반 `push`는 보통 거절됩니다. 히스토리가 다시 작성돼서 non-fast-forward가 되기 때문입니다.
- 이 경우 `git push --force-with-lease`로는 올릴 수 있지만, 다른 사람의 기준 히스토리를 바꾸는 행동이라서 매우 조심해야 합니다.
- 반대로 아직 원격에 올리지 않은 로컬 브랜치였다면, merge commit이 없어진 상태로 처음 push하는 것은 가능합니다.

## 관찰 포인트

- rebase todo 목록에서 commit 단위로 동작을 선택할 수 있습니다.
- 정리 후에는 commit 개수와 메시지가 달라집니다.
- `fixup`과 `squash`는 비슷하지만, 최종 commit 메시지 처리 방식이 다릅니다.

## 핵심 개념

- interactive rebase는 단순히 최신 `main` 위로 올리는 것을 넘어, 로컬 히스토리를 “읽기 좋은 이야기”로 편집하는 작업입니다.
- 핵심 목적은 협업 전에 내 히스토리를 논리적인 단위로 정리하는 데 있습니다.

## 자주 헷갈리는 포인트

- `rebase -i`는 squash만 하는 기능이 아닙니다. `reword`, `drop`, `fixup`도 자주 씁니다.
- 이미 공유된 commit에 대해 interactive rebase를 하면 다른 사람의 기준 히스토리가 깨질 수 있습니다.
- `drop`은 commit을 현재 브랜치 히스토리에서 없애므로 조심해야 합니다.

## 비교 대상

- [06-rebase](../06-rebase/README.md): 최신 `main` 위로 재배치하는 것이 중심입니다.

## 질문 거리

1. `squash`와 `fixup`은 어떤 상황에서 다르게 쓸까요?
2. 왜 interactive rebase는 PR 직전에 특히 유용할까요?
3. 어떤 commit은 남기고 어떤 commit은 합치거나 지워야 할까요?
