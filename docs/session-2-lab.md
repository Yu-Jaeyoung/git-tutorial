# Session 2 Lab

## 진행 원칙

- 모든 파트에서 `merge와 무엇이 다른가?`를 먼저 묻습니다.
- 기본 그래프 확인은 `git lg`로 하고, 숨겨진 시나리오 ref까지 확인할 때만 `git lga`를 씁니다.
- `rebase`, `cherry-pick`, `reset`은 강사가 먼저 위험도와 금지 사례를 말합니다.
- 공유된 히스토리를 재작성하지 않는다는 원칙을 반복합니다.
- 시나리오별 상세 설명은 [Scenario Index](scenarios/README.md) 아래 순서형 폴더 문서를 참고합니다.

## 1. Rebase

상세 설명: [06-rebase](scenarios/06-rebase/README.md)

초기화:

```bash
./bin/reset-lab rebase
git lg
```

예측 질문:

- merge 대신 rebase를 하면 그래프가 어떻게 달라질까?

실습:

```bash
git switch feature/payment
git rebase main
git lg
```

정리 포인트:

- feature commit들이 최신 `main` 뒤로 다시 복사된다.
- 결과는 더 직선형이지만, commit hash가 바뀐다.

abort를 실제로 연습하려면 아래 심화 실습을 추가합니다.

```bash
./bin/reset-lab rebase-conflict
git lg
git switch feature/payment
git rebase main
git status -sb
git rebase --abort
git lg
```

한 문장 규칙:

- `rebase`는 통합 전에 내 feature를 최신 `main` 위에 다시 올려놓는 작업이다.

## 2. Interactive rebase

상세 설명: [07-interactive-rebase](scenarios/07-interactive-rebase/README.md)

초기화:

```bash
./bin/reset-lab interactive-rebase
git lg
```

예측 질문:

- 5개의 지저분한 커밋을 리뷰 가능한 2개 정도로 줄이려면 무엇이 필요할까?

실습:

```bash
git switch feature/payment
git rebase -i main
```

편집기에서 아래처럼 정리합니다.

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

복구 명령도 함께 소개:

```bash
git rebase --abort
```

한 문장 규칙:

- `interactive rebase`는 PR 전에 로컬 히스토리를 읽기 좋은 단위로 정리하는 도구다.

## 3. Cherry-pick

상세 설명: [08-cherry-pick](scenarios/08-cherry-pick/README.md)

초기화:

```bash
./bin/reset-lab cherry-pick
git lg
git log --oneline hotfix/typo
```

예측 질문:

- hotfix 브랜치 전체를 합치고 싶지는 않은데, 특정 수정 하나만 필요하면?

실습:

```bash
git switch main
git cherry-pick <Fix customer-facing typo in README 커밋 해시>
git lg
```

복구 명령도 함께 소개:

```bash
git cherry-pick --abort
```

한 문장 규칙:

- `cherry-pick`은 브랜치가 아니라 commit 하나를 선택적으로 옮길 때 쓴다.

## 4. Revert

상세 설명: [09-revert](scenarios/09-revert/README.md)

초기화:

```bash
./bin/reset-lab revert
git lg
```

예측 질문:

- 이미 공유된 잘못된 commit을 지우지 않고 취소하려면?

실습:

```bash
git switch main
git revert --no-edit HEAD
git lg
```

정리 포인트:

- 잘못된 commit을 없애지 않고 “반대 commit”을 추가한다.
- 협업 중인 branch에서 가장 안전한 취소 방식이다.

한 문장 규칙:

- 공유된 히스토리는 `revert`로 되돌린다.

## 5. Reset + Reflog

상세 설명: [10-reset](scenarios/10-reset/README.md)

초기화:

```bash
./bin/reset-lab reset
git lg
```

### 5-1. `--soft`

```bash
git reset --soft HEAD~1
git status -sb
```

확인 포인트:

- commit만 뒤로 갔고 변경사항은 staging area에 남아 있다.

### 5-2. `--mixed`

다시 초기화:

```bash
./bin/reset-lab reset
```

실습:

```bash
git reset HEAD~1
git status -sb
```

확인 포인트:

- commit은 사라졌고 변경사항은 working tree에 남아 있다.

### 5-3. `--hard`

다시 초기화:

```bash
./bin/reset-lab reset
```

실습:

```bash
git reset --hard HEAD~1
git status -sb
git reflog --oneline -n 5
```

복구:

```bash
git reset --hard <reflog에서 찾은 "Add rollback drill note" 커밋 해시>
git lg
```

정리 포인트:

- `--hard`는 working tree까지 버리므로 가장 위험하다.
- 그래도 local에서는 `reflog`가 마지막 안전망이 된다.

한 문장 규칙:

- 로컬 정리는 `reset`, 그리고 마지막 안전망은 `reflog`다.

## 6. 종합 판단 퀴즈

학습자에게 아래 상황을 주고 이유까지 말하게 합니다.

1. 이미 원격에 공유된 잘못된 설정 commit을 취소해야 한다.
2. feature 브랜치를 최신 `main` 기준으로 정리한 뒤 PR을 올리고 싶다.
3. 작업 중인 변경사항을 잠깐 치우고 급한 hotfix를 먼저 처리해야 한다.
4. hotfix 브랜치 전체는 필요 없고 오타 수정 commit 하나만 가져오고 싶다.
5. 커밋은 없애고 싶지만 파일 변경은 남겨서 다시 commit하고 싶다.
