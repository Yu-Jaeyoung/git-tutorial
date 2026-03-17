# Scenario Index

시나리오 문서는 학습자가 개별 주제를 읽고 바로 실습한 뒤 질문을 이어갈 수 있도록 만든 상세 안내서입니다.

- 특정 개념을 깊게 설명하거나 복습 자료로 쓰려면 아래 시나리오 README를 엽니다.
- 모든 문서는 `./bin/reset-lab <scenario>`로 시작 상태를 맞춘다는 전제를 공유합니다.

## 추천 읽기 순서

### Start Here

1. [00-setting](00-setting/README.md): 어떤 저장소에서 시작하고, `git lg`와 `./bin/reset-lab`을 어떻게 쓰는지

### Session 1

1. [01-merge-ff](01-merge-ff/README.md): fast-forward merge가 언제 가능한지
2. [02-merge-commit](02-merge-commit/README.md): merge commit이 생기는 조건
3. [03-conflict](03-conflict/README.md): 충돌을 읽고 해결하는 법
4. [04-stash](04-stash/README.md): 커밋 전 작업을 잠시 치우는 법
5. [05-worktree](05-worktree/README.md): 브랜치 전환 없이 병렬 작업하는 법

### Session 2

1. [06-rebase](06-rebase/README.md): feature를 최신 `main` 위로 다시 놓는 법과 `rebase-conflict` abort drill
2. [07-interactive-rebase](07-interactive-rebase/README.md): 지저분한 커밋을 정리하는 법
3. [08-cherry-pick](08-cherry-pick/README.md): 특정 commit만 선택적으로 옮기는 법
4. [09-revert](09-revert/README.md): 공유된 실수를 안전하게 취소하는 법
5. [10-reset](10-reset/README.md): 로컬 히스토리를 되돌리고 `reflog`로 복구하는 법

## 읽는 법

- 먼저 [00-setting](00-setting/README.md)에서 실습 환경을 준비합니다.
- 그다음 `언제 쓰는가`에서 상황을 잡습니다.
- 그다음 `시작 상태 만들기`와 `실습 절차`를 그대로 따라갑니다.
- 중간중간 `관찰 포인트`에서 `git status -sb`, `git lg` 출력이 왜 그렇게 보이는지 설명합니다.
- 마지막 `질문 거리`는 학습자가 읽고 난 뒤 토론하거나 질문을 이어가기 위한 용도입니다.

## 명령 읽기 규칙

- `./bin/reset-lab <scenario>`에서 `./`는 현재 디렉터리, `bin/reset-lab`은 실습 저장소 안의 보조 스크립트, `<scenario>`는 실제 시나리오 이름이 들어갈 자리입니다.
- `git lg`는 실습 저장소에 미리 등록된 alias입니다. 학생 입장에서는 `git log`를 그래프형으로 보기 쉽게 줄여 둔 명령이라고 이해하면 충분합니다.
- `git status -sb`에서 `-s`는 short, `-b`는 branch의 약자입니다. 파일 상태를 짧게 보고 현재 브랜치도 함께 확인할 때 씁니다.
- `HEAD`는 현재 내가 서 있는 commit을 뜻하고, `HEAD~1`은 현재 commit의 바로 이전 부모 commit을 뜻합니다.
- `<커밋 해시>`처럼 꺾쇠 괄호로 적힌 값은 설명용 자리표시자입니다. 실제 명령을 실행할 때는 직접 찾은 값으로 바꿔 넣어야 합니다.
- `stash@{0}`는 가장 최근 stash를 가리키는 표기입니다. 숫자가 커질수록 더 오래된 stash입니다.
