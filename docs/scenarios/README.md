# Scenario Index

시나리오 문서는 학습자가 개별 주제를 읽고 바로 실습한 뒤 질문을 이어갈 수 있도록 만든 상세 안내서입니다.

- 특정 개념을 깊게 설명하거나 복습 자료로 쓰려면 아래 시나리오 폴더를 엽니다.
- 각 시나리오 폴더에는 개념과 실습 흐름을 담은 `README.md`, 시나리오 전용 명령과 옵션을 담은 `COMMANDS.md`가 함께 있습니다.
- 모든 문서는 `./bin/reset-lab <scenario>`로 시작 상태를 맞춘다는 전제를 공유합니다.
- 공통 명령과 revision 표기는 [command-reference](reference/README.md)에 모아 두었습니다.

## 문서 구조

- [00-setting](00-setting/README.md): 실습 저장소를 어디서 만들고, 어떤 명령부터 확인해야 하는지 정리한 시작 문서
- [command-reference](reference/README.md): 여러 시나리오에서 반복되는 공통 Git 명령, revision 표기, 쉘 표현 모음
- 각 시나리오의 `README.md`: 언제 쓰는가, 실습 절차, 관찰 포인트, 질문 거리
- 각 시나리오의 `COMMANDS.md`: 해당 시나리오에서만 자주 쓰는 명령과 옵션 설명

## 추천 읽기 순서

### Start Here

1. [00-setting](00-setting/README.md): 어떤 저장소에서 시작하고, `git lg`와 `./bin/reset-lab`을 어떻게 쓰는지

### Session 1

1. [01-merge-ff](01-merge-ff/README.md): fast-forward merge가 언제 가능한지
2. [02-merge-commit](02-merge-commit/README.md): merge commit이 생기는 조건
3. [03-conflict](03-conflict/README.md): 충돌을 읽고 해결하는 법
4. [04-stash](04-stash/README.md): 커밋 전 작업을 잠시 치우는 법
5. [05-worktree](05-worktree/README.md): 브랜치 전환 없이 병렬 작업하고 `list`와 `remove`로 정리하는 법

### Session 2

1. [06-rebase](06-rebase/README.md): feature를 최신 `main` 위로 다시 놓고, 충돌과 `rebase --abort`를 다루는 법
2. [07-interactive-rebase](07-interactive-rebase/README.md): 지저분한 커밋 정리, merge commit, `--rebase-merges`, `reflog` 복구까지 다루는 법
3. [08-cherry-pick](08-cherry-pick/README.md): 특정 commit만 선택적으로 옮기는 법
4. [09-revert](09-revert/README.md): 공유된 실수를 안전하게 취소하는 법
5. [10-reset](10-reset/README.md): `--soft`, `--mixed`, `--hard`와 `reflog` 복구를 익히는 법

## 읽는 법

- 먼저 [00-setting](00-setting/README.md)에서 실습 환경을 준비합니다.
- 공통 명령이 헷갈리면 [command-reference](reference/README.md)를 먼저 읽습니다.
- 그다음 `언제 쓰는가`에서 상황을 잡습니다.
- 그다음 `시작 상태 만들기`와 `실습 절차`를 그대로 따라갑니다.
- 실습 중 옵션 의미가 헷갈리면 같은 폴더의 `COMMANDS.md`를 바로 펼쳐 봅니다.
- 중간중간 `관찰 포인트`에서 `git status -sb`, `git lg` 출력이 왜 그렇게 보이는지 설명합니다.
- 마지막 `질문 거리`는 학습자가 읽고 난 뒤 토론하거나 질문을 이어가기 위한 용도입니다.

## 명령 읽기 규칙

- 공통 명령과 표기는 [command-reference](reference/README.md)를 먼저 읽습니다.
- 각 시나리오에서만 쓰는 세부 명령과 옵션은 각 폴더의 `COMMANDS.md`를 참고합니다.
