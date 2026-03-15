# Git Workshop Kit

`merge`, `rebase`, `interactive rebase`, `cherry-pick`, `stash`, `worktree`, `revert`, `reset`, `reflog`를 2회 워크숍으로 가르칠 수 있도록 만든 강사용 자료 저장소입니다.

## 포함 내용

- 2회차 수업 운영안: `docs/course-guide.md`
- 1회차 실습 시나리오: `docs/session-1-lab.md`
- 2회차 실습 시나리오: `docs/session-2-lab.md`
- 시나리오별 상세 README: `docs/scenarios/README.md`
- 강사용 요약 치트시트: `docs/facilitator-cheatsheet.md`
- 평가 체크리스트: `docs/assessment.md`
- 실습용 Git 저장소 생성 스크립트: `scripts/setup-workshop-lab.sh`

## 빠른 시작

```bash
./scripts/setup-workshop-lab.sh
cd generated/git-workshop-lab
./bin/reset-lab merge-ff
git lg
```

기본 생성 경로는 `generated/git-workshop-lab`입니다. 다른 위치를 쓰고 싶으면 경로를 인자로 넘기면 됩니다.

```bash
./scripts/setup-workshop-lab.sh /tmp/git-workshop-lab
```

## 생성되는 실습 저장소 특징

- 작은 텍스트 기반 프로젝트로 구성되어 충돌과 히스토리 변화가 잘 보입니다.
- `git lg` 별칭이 자동으로 설정되며, 수업 중에는 현재 브랜치 구조만 보여줍니다.
- 필요하면 `git lga`로 숨겨진 시나리오 태그까지 포함한 전체 ref 그래프를 볼 수 있습니다.
- 아래 시나리오를 `./bin/reset-lab <scenario>`로 반복 재현할 수 있습니다.

```text
merge-ff
merge-commit
conflict
stash
worktree
rebase
rebase-conflict
interactive-rebase
cherry-pick
revert
reset
```

## 권장 운영 방식

- 모든 실습은 `상황 설명 -> 결과 예측 -> 명령 실행 -> git lg 확인 -> 복구` 순서로 진행합니다.
- 명령어보다 커밋 그래프를 먼저 읽게 합니다.
- `reset`은 반드시 `reflog`와 함께 다룹니다.
- 공유된 히스토리는 `revert`, 로컬 정리는 `reset`이라는 규칙을 반복합니다.

## 문서 읽는 순서

- 수업 전체 흐름부터 보려면 `docs/course-guide.md`를 먼저 읽습니다.
- 회차별 진행은 `docs/session-1-lab.md`, `docs/session-2-lab.md`를 사용합니다.
- 개별 개념을 깊게 설명하거나 학습자가 읽고 질문하게 하려면 `docs/scenarios/README.md` 아래 시나리오 문서를 사용합니다.
- 시나리오 폴더는 `01-merge-ff`처럼 실제 학습 순서가 드러나도록 번호를 붙여 정렬했습니다.
