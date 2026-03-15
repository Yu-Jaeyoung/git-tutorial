# conflict

한 줄 요약: 충돌은 Git이 망가진 상태가 아니라, 자동 결정이 어려워 사람이 최종 내용을 선택해야 하는 대기 상태입니다.

- 수업 흐름: [Session 1 Lab](../../session-1-lab.md)
- 비교 시나리오: [02-merge-commit](../02-merge-commit/README.md), [06-rebase](../06-rebase/README.md)

## 언제 쓰는가

- 같은 줄이나 겹치는 영역을 양쪽 브랜치에서 다르게 수정했을 때
- 학습자에게 conflict marker와 해결 절차를 직접 보여주고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab conflict
git lg
```

## 실습 절차

```bash
git switch main
git merge feature/login
git status -sb
```

`config.txt`를 열어 conflict marker를 읽고 원하는 최종 값으로 수정합니다.

```bash
git add config.txt
git commit -m "Resolve login rollout conflict"
git lg
```

복구를 보여주고 싶다면 다시 초기화한 뒤 아래도 실습합니다.

```bash
git merge --abort
```

## 명령과 옵션 풀이

- `./bin/reset-lab conflict`: 충돌이 나도록 미리 준비된 상태로 되돌립니다.
- `git lg`: 현재 브랜치 구조를 그래프로 확인합니다.
- `git switch main`: merge를 실행할 기준 브랜치를 `main`으로 맞춥니다.
- `git merge feature/login`: `feature/login`을 현재 브랜치에 병합합니다. 이 시나리오에서는 같은 줄을 양쪽에서 바꿨기 때문에 충돌이 납니다.
- `git status -sb`: `status` 출력에서 충돌 파일과 현재 브랜치를 짧게 확인합니다. `-s`는 short, `-b`는 branch입니다.
- `git add config.txt`: `add`는 충돌 해결 후 “이 파일은 이제 해결됐다”고 Git에 알리는 역할도 합니다. `config.txt`는 해결한 파일 경로입니다.
- `git commit -m "Resolve login rollout conflict"`: `commit`은 해결 결과를 새 commit으로 남기고, `-m`은 commit 메시지를 명령행에서 바로 적는 옵션입니다.
- `git merge --abort`: `--abort`는 진행 중인 merge를 중단하고 merge 시작 전 상태로 되돌립니다.

## 관찰 포인트

- `git status -sb`는 충돌이 해결되지 않았다고 알려줍니다.
- `config.txt` 안에는 `<<<<<<<`, `=======`, `>>>>>>>` 형태의 conflict marker가 생깁니다.
- 충돌 파일을 수정한 뒤 `git add`를 해야 Git이 “이 파일은 해결됐다”고 인식합니다.

## 핵심 개념

- conflict는 merge가 실패한 것이 아니라, Git의 자동 판단 범위를 넘은 것입니다.
- 해결 절차는 `충돌 확인 -> 최종 내용 결정 -> git add -> git commit`입니다.

## 자주 헷갈리는 포인트

- `git add`는 충돌 해결 후 “이제 괜찮다”고 표시하는 단계입니다.
- 충돌은 merge에서만 생기지 않습니다. rebase나 cherry-pick 중에도 생길 수 있습니다.

## 비교 대상

- [02-merge-commit](../02-merge-commit/README.md): 갈라진 이력이 있어도 수정 영역이 안 겹치면 자동 병합됩니다.
- [06-rebase](../06-rebase/README.md): rebase도 commit을 다시 적용하다가 같은 종류의 conflict를 만들 수 있습니다.

## 질문 거리

1. 왜 conflict marker를 Git이 자동으로 없애지 않을까요?
2. `git add`는 충돌 해결 맥락에서 어떤 의미를 갖나요?
3. conflict와 merge commit은 같은 개념일까요, 다른 개념일까요?
