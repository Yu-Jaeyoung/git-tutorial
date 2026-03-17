# interactive-rebase

한 줄 요약: `rebase -i`는 commit 순서와 메시지, 묶음 방식을 직접 편집해 로컬 히스토리를 리뷰하기 좋은 형태로 정리하는 도구입니다.

- 비교 시나리오: [06-rebase](../06-rebase/README.md)

## 언제 쓰는가

- PR을 올리기 전에 지저분한 로컬 commit을 정리하고 싶을 때
- 의미 없는 중간 commit, typo fix, debug 제거 같은 흔적을 합치고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab interactive-rebase
git lg
```

## 실습 1: 선형 히스토리 정리하기

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
git status -sb
```

## 실습 2: `edit`로 멈춘 뒤 `--abort` 해보기

다시 시작 상태를 맞춘 뒤, 일부러 rebase 중간에 멈춰 봅니다.

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git rebase -i main
```

편집기에서 첫 줄만 아래처럼 바꿉니다.

```text
edit <draft payment copy 커밋 해시> draft payment copy
pick <나머지 커밋들>
```

rebase가 첫 commit에서 멈추면 상태를 확인합니다.

```bash
git status -sb
git lg
```

이번 실습에서는 수정하지 말고 중단합니다.

```bash
git rebase --abort
git lg
git status -sb
```

## 실습 3: merge commit이 있는 상태를 직접 만들어 보기

기본 시나리오는 선형 commit 정리용입니다. merge commit까지 같이 다루려면 아래처럼 작은 보조 브랜치를 직접 만들어 보는 편이 가장 좋습니다.

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git switch -c spike/payment-helper HEAD~3
printf '\nMERGE_HELPER_NOTE=yes\n' >> README.md
git commit -am "Add payment helper note from spike"
git switch feature/payment
printf '\nPAYMENT_COPY_PASS=yes\n' >> config.txt
git commit -am "Note payment copy pass on feature"
git merge --no-ff spike/payment-helper -m "Merge payment helper branch"
git lg
```

이제 `HEAD`는 merge commit입니다. 부모 관계를 확인해 보면 `^`와 `~`가 어떻게 다른지도 같이 보입니다.

```bash
git rev-parse --short HEAD
git rev-parse --short HEAD^
git rev-parse --short HEAD^2
git rev-parse --short HEAD~1
git rev-parse --short HEAD~2
```

읽는 법:

- `HEAD`: 현재 merge commit
- `HEAD^` 또는 `HEAD^1`: 첫 번째 부모
- `HEAD^2`: 두 번째 부모
- `HEAD~1`: 첫 번째 부모를 한 번 따라간 위치
- `HEAD~2`: 첫 번째 부모 체인을 두 번 따라간 위치

## 실습 4: 같은 `HEAD~2`에서 기본 `-i`와 `--rebase-merges` 비교하기

위 merge commit 상태에서 아래 두 명령을 비교합니다.

```bash
git rebase -i HEAD~2
git rebase -i --rebase-merges HEAD~2
```

중요한 점은 `HEAD~2`가 가리키는 commit은 두 경우 모두 같다는 것입니다. 달라지는 것은 todo 목록과 최종 그래프입니다.

기본 `git rebase -i HEAD~2`에서는 보통 merge commit 줄 자체가 직접 보이지 않고, merge 안에 있던 일반 commit들이 선형 목록으로 펼쳐집니다. 예를 들면 이런 식입니다.

```text
pick <feature 쪽 commit>
pick <side branch 쪽 commit>
```

반대로 `git rebase -i --rebase-merges HEAD~2`에서는 merge 구조를 재구성하기 위한 명령이 함께 보일 수 있습니다.

```text
label onto
reset <base>
pick <side branch commit>
label spike-payment-helper

reset onto
pick <feature commit>
merge -C <merge commit> spike-payment-helper
```

즉:

- `HEAD~2`의 의미는 안 바뀝니다.
- 기본 `-i`는 merge topology를 평평하게 펼치려 합니다.
- `--rebase-merges`는 merge topology를 다시 만들려고 시도합니다.

## 기본 `-i`와 `--rebase-merges` 결과 비교

merge commit이 있는 상태에서 rebase를 완료하면 대략 이런 차이가 납니다.

기본 `git rebase -i`:

```text
Before:  base -- F -- M
                  \ /
                   S

After:   base -- F' -- S'
```

`git rebase -i --rebase-merges`:

```text
Before:  base -- F -- M
                  \ /
                   S

After:   base -- F' -- M'
                  \  /
                   S'
```

앞의 경우 merge commit이 사라질 수 있고, 뒤의 경우 merge commit이 재작성된 형태로 유지될 수 있습니다.

## 원격 push까지 생각하면 무엇이 달라지나

- 기본 `interactive rebase`를 완료하면 기존 commit hash가 새 hash로 다시 써집니다.
- merge commit이 있던 브랜치를 평평하게 만들었다면, 원격에 있던 기존 히스토리와 로컬 히스토리가 달라집니다.
- 이 상태에서 원격 브랜치가 이미 예전 merge commit을 가지고 있었다면 일반 `push`는 보통 거절됩니다.
- 거절 이유는 “merge commit이 없어져서”라기보다, 원격 기준으로는 non-fast-forward rewrite가 되기 때문입니다.
- 아직 원격에 올리지 않은 로컬 브랜치라면 일반 `push`가 가능합니다.

## 실습 5: 완료된 interactive rebase를 `reflog`로 복구하기

중요한 구분은 이렇습니다.

- rebase가 진행 중일 때: `git rebase --abort`
- rebase가 이미 끝난 뒤: `git reflog`로 이전 `HEAD`를 찾고 `git reset --hard`로 복구

아래 실습은 두 번째 경우를 다룹니다.

```bash
./bin/reset-lab interactive-rebase
git switch feature/payment
git rebase -i main
git lg
git reflog show feature/payment --oneline -n 10
```

편집기에서는 실습 1과 같은 방식으로 commit을 정리합니다. rebase가 끝났다면 현재 상태를 백업한 뒤, 브랜치 reflog에서 rebase 전 tip commit을 찾아 돌아갑니다.

```bash
git branch backup/after-interactive-rebase
git reset --hard <reflog에서 찾은 rebase 전 커밋 해시>
git lg
```

관찰:

- 완료된 interactive rebase 뒤에는 `git rebase --abort`가 통하지 않습니다.
- reflog에는 보통 rebase 시작 전 `feature/payment` 위치가 남아 있습니다.
- merge commit이 사라진 경우도 같은 원리로 복구할 수 있습니다. “merge commit을 cherry-pick해서 되살리는 것”이 아니라, rebase 전 브랜치 위치 자체로 돌아가는 접근입니다.

## 명령과 옵션 풀이

- `./bin/reset-lab interactive-rebase`: interactive rebase 실습 상태를 다시 만듭니다.
- `git lg`: rebase 전후 commit 구조를 비교합니다.
- `git switch feature/payment`: 정리할 commit들이 있는 브랜치로 이동합니다.
- `git rebase -i main`: `rebase`는 commit을 다시 적용하고, `-i`는 interactive의 약자로 todo 목록을 편집할 수 있게 합니다. `main`은 현재 commit들을 다시 얹을 기준 브랜치입니다.
- `git rebase -i --rebase-merges main`: merge commit 구조까지 보존하면서 interactive rebase를 하고 싶을 때 씁니다. 기본 `rebase -i`와 달리 merge topology를 유지하려고 시도합니다.
- `git rebase --abort`: 편집 도중 꼬였거나 결과가 마음에 들지 않으면 rebase 자체를 취소합니다.
- `git reflog show feature/payment --oneline -n 10`: 완료된 interactive rebase를 되돌릴 때, rebase 전 `feature/payment` tip을 찾는 데 유용합니다.
- `git branch backup/after-interactive-rebase`: 현재 rewrite 결과를 잃고 싶지 않을 때 임시 백업 브랜치를 만듭니다.
- `git reset --hard <reflog에서 찾은 rebase 전 커밋 해시>`: reflog에서 찾은 rebase 시작 전 상태로 브랜치를 되돌립니다.
- `git switch -c spike/payment-helper HEAD~3`: `-c`는 새 브랜치 생성, `HEAD~3`은 현재 위치에서 첫 번째 부모를 세 번 따라간 commit을 기준점으로 삼는다는 뜻입니다.
- `git merge --no-ff spike/payment-helper -m "Merge payment helper branch"`: `--no-ff`는 fast-forward가 가능해도 merge commit을 강제로 남깁니다. merge commit이 있는 interactive rebase 예시를 만들기 위해 씁니다.
- `git rev-parse --short HEAD^2`: `rev-parse`는 Git이 이해하는 revision을 실제 hash로 풀어 줍니다. `--short`는 짧은 hash 표기이고, `HEAD^2`는 현재 merge commit의 두 번째 부모를 뜻합니다.

## rebase todo 명령 풀이

- `pick`: 해당 commit을 그대로 유지합니다.
- `reword`: 내용은 그대로 두고 commit 메시지만 수정합니다.
- `edit`: 해당 commit에서 rebase를 멈추고, amend나 파일 수정 같은 추가 편집을 하게 해 줍니다.
- `squash`: 현재 commit을 바로 위 commit과 합치고, 메시지도 함께 정리합니다.
- `fixup`: 현재 commit을 바로 위 commit과 합치되, 현재 commit 메시지는 버립니다.
- `drop`: 해당 commit을 현재 브랜치 히스토리에서 제외합니다.
- `label`: 현재 위치에 이름표를 붙입니다. `--rebase-merges`에서 자주 보입니다.
- `reset`: 이전에 붙여 둔 label 위치로 HEAD를 되돌립니다.
- `merge`: 지정한 label을 현재 위치와 다시 합쳐 merge commit을 재구성합니다.

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

### `HEAD~2`는 `--rebase-merges`를 붙이면 다른 commit을 가리키나요?

- 아닙니다. `HEAD~2`는 언제나 첫 번째 부모 체인을 두 번 따라간 같은 commit을 가리킵니다.
- 달라지는 것은 “그 기준점 이후 구간을 todo 목록에 어떻게 표현하느냐”입니다.
- 기본 `-i`는 선형 목록으로, `--rebase-merges`는 `label/reset/merge`를 포함한 구조형 목록으로 보여줄 수 있습니다.

## 관찰 포인트

- rebase todo 목록에서 commit 단위로 동작을 선택할 수 있습니다.
- 정리 후에는 commit 개수와 메시지가 달라집니다.
- `fixup`과 `squash`는 비슷하지만, 최종 commit 메시지 처리 방식이 다릅니다.
- `edit`로 멈춰 보면 interactive rebase가 “한 번에 magic처럼 바꾸는 명령”이 아니라 commit을 순서대로 다시 적용하는 과정이라는 점이 더 잘 보입니다.
- merge commit이 있는 상태에서는 기본 `-i`와 `--rebase-merges`가 전혀 다른 todo 목록을 만들 수 있습니다.
- 완료된 interactive rebase 복구는 결국 `reflog + reset`이라는 점이 reset 수업과 직접 연결됩니다.

## 핵심 개념

- interactive rebase는 단순히 최신 `main` 위로 올리는 것을 넘어, 로컬 히스토리를 “읽기 좋은 이야기”로 편집하는 작업입니다.
- 핵심 목적은 협업 전에 내 히스토리를 논리적인 단위로 정리하는 데 있습니다.
- merge commit이 있는 히스토리를 다룰 때는 “선형화할 것인가, merge 구조를 유지할 것인가”를 먼저 결정해야 합니다.

## 자주 헷갈리는 포인트

- `rebase -i`는 squash만 하는 기능이 아닙니다. `reword`, `drop`, `fixup`도 자주 씁니다.
- 이미 공유된 commit에 대해 interactive rebase를 하면 다른 사람의 기준 히스토리가 깨질 수 있습니다.
- `drop`은 commit을 현재 브랜치 히스토리에서 없애므로 조심해야 합니다.
- interactive rebase를 “열었다 닫는 것”만으로 merge commit이 사라지는 것은 아닙니다. 기본 interactive rebase를 실제로 완료했을 때 merge topology가 평평해질 수 있습니다.

## 비교 대상

- [06-rebase](../06-rebase/README.md): 최신 `main` 위로 재배치하는 것이 중심입니다.

## 질문 거리

1. `squash`와 `fixup`은 어떤 상황에서 다르게 쓸까요?
2. 왜 interactive rebase는 PR 직전에 특히 유용할까요?
3. 어떤 commit은 남기고 어떤 commit은 합치거나 지워야 할까요?
