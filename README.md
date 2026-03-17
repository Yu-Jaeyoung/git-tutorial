# Git Workshop Kit

`merge`, `rebase`, `interactive rebase`, `cherry-pick`, `stash`, `worktree`, `revert`, `reset`, `reflog`, `tag`를 실습 중심으로 가르칠 수 있도록 만든 Git 워크숍 자료 저장소입니다.

## 포함 내용

- 시나리오별 상세 README: `docs/scenarios/README.md`
- 실습용 Git 저장소 생성 스크립트: `scripts/setup-workshop-lab.sh`
- 학생 배포본 폴더: `student-kit/`

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
tag
```

## 권장 운영 방식

- 모든 실습은 `상황 설명 -> 결과 예측 -> 명령 실행 -> git lg 확인 -> 복구` 순서로 진행합니다.
- 명령어보다 커밋 그래프를 먼저 읽게 합니다.
- `reset`은 반드시 `reflog`와 함께 다룹니다.
- 공유된 히스토리는 `revert`, 로컬 정리는 `reset`이라는 규칙을 반복합니다.

## 학생 배포 방법

- 학생에게는 `student-kit/` 폴더만 별도로 전달하면 됩니다.
- 학생용 배포본에는 상세 시나리오 문서 대신 `setup-student-lab.sh`와 짧은 안내문만 들어 있습니다.
- 학생은 `student-kit/README.md`를 보고 `./setup-student-lab.sh`로 실습 저장소를 만든 뒤, `QUICK-CHECKLIST.md` 순서대로 진행하면 됩니다.
- zip 배포본이 필요하면 `./scripts/package-student-kit.sh`를 실행합니다.

```bash
./scripts/package-student-kit.sh
```

기본 생성 경로는 `generated/git-workshop-student-kit.zip`입니다.

## 문서 읽는 순서

- 처음 시작할 때는 `docs/scenarios/00-setting/README.md`를 먼저 읽습니다.
- 개별 개념을 깊게 설명하거나 학습자가 읽고 질문하게 하려면 `docs/scenarios/README.md` 아래 시나리오 문서를 사용합니다.
- 시나리오 인덱스에서 추천 순서대로 진행하면 전체 워크숍 흐름을 그대로 따라갈 수 있습니다.
- 시나리오 폴더는 `01-merge-ff`처럼 실제 학습 순서가 드러나도록 번호를 붙여 정렬했습니다.
