# Facilitator Cheatsheet

## 위험도 라벨

| 명령 | 위험도 | 강의 포인트 |
| --- | --- | --- |
| `merge` | 안전 | 기존 commit을 유지한 채 결합 |
| `stash` | 안전 | 임시 보관, 충돌 가능성은 있음 |
| `worktree` | 안전 | 작업 맥락 분리 |
| `revert` | 안전 | 공유된 히스토리 취소 |
| `rebase` | 주의 | commit hash 변경 |
| `interactive rebase` | 주의 | 로컬 히스토리 재작성 |
| `cherry-pick` | 주의 | commit 선택 이식, 중복 위험 |
| `reset --soft` | 주의 | branch 이동 |
| `reset --mixed` | 주의 | branch 이동 + staging 해제 |
| `reset --hard` | 고위험 | working tree까지 삭제 |

## 반드시 반복할 문장

- branch는 commit을 가리키는 이름표다.
- 수업 중 그래프는 `git lg`, 디버깅용 전체 ref 확인은 `git lga`다.
- merge와 rebase는 둘 다 통합이지만, 히스토리를 표현하는 방식이 다르다.
- 공유된 히스토리는 `revert`, 로컬 정리는 `reset`이다.
- `interactive rebase`는 PR 전에 로컬에서만 쓴다.
- `reflog`는 로컬에서 잃어버린 commit을 찾는 안전망이다.

## 자주 나오는 오해

| 오해 | 바로잡는 설명 |
| --- | --- |
| rebase가 merge보다 항상 좋다 | 좋고 나쁨이 아니라 그래프와 협업 규칙의 차이다 |
| conflict가 나면 Git이 고장 났다 | 충돌은 사람이 결정해야 하는 대기 상태다 |
| reset은 항상 위험하다 | `soft`, `mixed`, `hard`가 무엇을 움직이는지 구분하면 안전하게 쓸 수 있다 |
| stash는 무조건 안전하다 | stash도 충돌할 수 있고 오래 쌓이면 잊기 쉽다 |
| worktree는 고급 기능이라 실무와 멀다 | hotfix와 feature를 동시에 다룰 때 매우 현실적이다 |

## 복구용 명령

```bash
git merge --abort
git rebase --abort
git cherry-pick --abort
git revert --abort
git reflog --oneline -n 10
git reset --hard <commit>
```

## 강사용 체크 질문

- 지금 `HEAD`는 어디를 가리키고 있나요?
- 이 명령은 commit을 새로 만들까요, 기존 commit을 옮길까요?
- 협업 중인 브랜치인가요, 개인 로컬 브랜치인가요?
- 실패했을 때 되돌리는 명령은 무엇인가요?

## 권장 마무리 멘트

- `merge`는 결합의 기본값이다.
- `rebase`는 깔끔한 히스토리를 위한 선택지다.
- `cherry-pick`은 수술처럼 정확해야 한다.
- `reset`은 강력하지만 `reflog`와 함께 써야 안심할 수 있다.
