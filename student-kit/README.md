# Git Workshop Student Kit

이 폴더는 학생에게 배포하는 최소 실습 패키지입니다. 상세 시나리오 문서는 제외되어 있고, 이 폴더만 받아도 실습 저장소를 만들 수 있게 구성했습니다.

## 들어 있는 파일

- `setup-student-lab.sh`: 실습용 Git 저장소를 생성하는 스크립트
- `QUICK-CHECKLIST.md`: 실습 순서와 각 단계의 최소 명령, 확인 포인트

## 시작 방법

```bash
cd student-kit
./setup-student-lab.sh
cd generated/git-workshop-lab
git status -sb
git lg
```

기본 생성 경로는 `generated/git-workshop-lab`입니다. 다른 경로를 쓰고 싶으면 인자로 넘기면 됩니다.

```bash
./setup-student-lab.sh /tmp/git-workshop-lab
```

## 실습 순서

1. `merge-ff`
2. `merge-commit`
3. `conflict`
4. `stash`
5. `worktree`
6. `rebase`
7. `rebase-conflict`
8. `interactive-rebase`
9. `cherry-pick`
10. `revert`
11. `reset`

## 진행 방식

1. `./bin/reset-lab <scenario>`로 시작 상태를 맞춥니다.
2. 바로 `git status -sb`, `git lg`를 확인합니다.
3. `QUICK-CHECKLIST.md`에 적힌 최소 명령을 실행합니다.
4. 명령을 한 줄 칠 때마다 `git status -sb` 또는 `git lg`를 다시 봅니다.
5. 마지막에는 “무엇이 바뀌었는가”를 한 문장으로 말해 봅니다.

## 꼭 체크할 것

- 현재 브랜치가 맞는가
- working tree가 깨끗한가
- merge commit이 생겼는가
- commit hash가 바뀌었는가
- 충돌이 발생했다면 왜 발생했는가
- `--abort`, `reflog`, `reset-lab` 중 무엇으로 복구할 수 있는가

이 패키지는 일부러 설명을 짧게 남겨 둔 버전입니다. 명령 의미나 결과가 이해되지 않으면 체크리스트를 기준으로 먼저 관찰하고, 그다음 질문을 이어가면 됩니다.
