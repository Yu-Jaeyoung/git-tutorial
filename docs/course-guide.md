# 2회 워크숍 운영안

## 전체 목표

- 학습자가 Git 명령을 외우는 대신 커밋 그래프를 기준으로 판단하게 만든다.
- `merge/rebase`는 브랜치 통합 방식으로, `interactive rebase/cherry-pick`은 히스토리 편집 도구로, `stash/worktree/revert/reset`은 작업 관리와 복구 도구로 묶어 이해하게 한다.
- 최소 2번 이상 의도적인 실패와 복구를 경험하게 한다.

## 사전 준비

| 항목 | 기준 |
| --- | --- |
| Git 버전 | Git 2.38 이상 권장 |
| 도구 | 터미널, 텍스트 에디터, 프로젝터 |
| 저장소 생성 | `./scripts/setup-workshop-lab.sh` 실행 |
| 실습 기준 저장소 | 생성된 `git-workshop-lab` |
| 그래프 확인 | 기본은 `git lg`, 전체 refs가 필요할 때만 `git lga` 사용 |

## 세션 1: 브랜치 통합과 충돌 해결

| 시간 | 주제 | 핵심 질문 | 결과물 |
| --- | --- | --- | --- |
| 20분 | Git 내부 모델 | `HEAD`, branch, index, working tree는 어떻게 연결되는가? | 화이트보드 그림 |
| 20분 | Fast-forward merge | 왜 merge commit이 없을 수 있는가? | `merge-ff` 그래프 |
| 15분 | Merge commit | 언제 두 줄기 이력이 유지되는가? | `merge-commit` 그래프 |
| 35분 | Conflict 해결 | 충돌은 실패가 아니라 어떤 상태인가? | conflict 해결 commit |
| 25분 | `stash` | 커밋하지 않고 작업을 잠시 치우려면? | stash 생성/복원 |
| 25분 | `worktree` | 브랜치 전환 없이 병렬 작업하려면? | 두 작업 디렉터리 |
| 10분 | 회고 | `merge`, `stash`, `worktree`는 언제 쓰는가? | 말로 설명 |

## 세션 2: 히스토리 정리와 복구

| 시간 | 주제 | 핵심 질문 | 결과물 |
| --- | --- | --- | --- |
| 15분 | 세션 1 복습 | merge와 rebase의 차이는 그래프에서 어떻게 보이는가? | 비교 설명 |
| 35분 | `rebase` | feature를 최신 `main` 위로 다시 놓는다는 것은 무엇인가? | rebase 후 그래프 |
| 40분 | `interactive rebase` | 지저분한 커밋을 어떻게 정리할 것인가? | 정리된 feature history |
| 20분 | `cherry-pick` | 브랜치 전체가 아닌 특정 커밋만 옮기려면? | cherry-pick된 commit |
| 25분 | `revert` | 공유된 실수를 안전하게 되돌리려면? | revert commit |
| 30분 | `reset` + `reflog` | 로컬 히스토리를 어떻게 되돌리고 복구하는가? | soft/mixed/hard 비교 |
| 15분 | 종합 판단 퀴즈 | 어떤 상황에 어떤 명령을 고를 것인가? | 구두 답변 |

## 강의 운영 팁

- 각 실습 전에는 반드시 `지금 브랜치 포인터가 어디를 가리키는지` 먼저 묻습니다.
- 충돌, rebase, cherry-pick, reset 파트에서는 `abort` 또는 `reflog`를 꼭 보여줘서 실패 공포를 낮춥니다.
- 학습자가 “왜 이 명령을 쓰는가”를 설명하지 못하면 한 번 더 그래프를 보게 합니다.
- 실습을 다시 시작할 때는 체크포인트를 복원하기보다 `./bin/reset-lab`로 동일한 상태를 재현합니다.
