# github-collab

한 줄 요약: 실제 GitHub remote를 두고 2명이 branch, PR, 선행 merge, conflict, local 해결, 최종 merge까지 한 번에 경험하는 협업 캡스톤입니다.

- 비교 시나리오: [03-conflict](../03-conflict/README.md), [06-rebase](../06-rebase/README.md), [09-revert](../09-revert/README.md)

## 언제 쓰는가

- 로컬 `reset-lab` 실습을 거의 마무리한 뒤, 실제 협업 흐름으로 감각을 옮기고 싶을 때
- GitHub PR과 로컬 Git 명령이 어떻게 이어지는지 한 번에 보여 주고 싶을 때
- “왜 remote에서 conflict가 생기는가”를 실제로 겪게 하고 싶을 때

## 시작 상태 만들기

이 시나리오는 현재 워크숍에서 유일하게 `./bin/reset-lab <scenario>`를 쓰지 않습니다. 대신 GitHub에 새 연습용 저장소를 만들고, 학생 A와 학생 B가 같은 remote를 clone해서 시작합니다.

강사 준비:

1. GitHub에서 새 저장소를 만듭니다. 이름은 `git-collab-capstone`으로 고정합니다.
2. default branch는 `main`으로 둡니다.
3. branch protection은 강제하지 않지만, 수업 규칙으로 `main` 직접 push 금지를 선언합니다.
4. 학생 B를 collaborator로 추가합니다.
5. 아래 파일 4개를 가진 초기 commit 하나를 만들어 둡니다.

`README.md`

```text
# GitHub Collaboration Capstone

Practice clone, branch, PR, conflict resolution, and merge.
```

`app.txt`

```text
APP_NAME=collab-capstone
LOGIN_STATUS=planned
NOTIFICATION_MODE=email
```

`config.txt`

```text
WELCOME_MESSAGE=Hello team
RELEASE_NOTE_STATUS=draft
```

`docs/release-checklist.md`

```text
# Release Checklist

- reviewer: TBD
- rollout window: Friday 18:00
- customer notice: draft
```

6. 저장소 URL을 두 학생에게 공유합니다.

## 실습 절차

### 1. 학생 A: clean PR 만들기

학생 A는 아래 흐름으로 진행합니다.

```bash
git clone <repo-url>
cd git-collab-capstone
git switch -c feature/a-login-copy
```

수정 내용은 고정합니다.

- `docs/release-checklist.md`의 `- reviewer: TBD`를 `- reviewer: Student A`로 변경
- `README.md` 맨 아래에 `- login rollout owner: Student A` 한 줄 추가

그다음 commit과 push를 진행합니다.

```bash
git add .
git commit -m "Update login copy for release"
git push -u origin feature/a-login-copy
```

이후 GitHub에서 `feature/a-login-copy -> main` PR을 생성합니다.

### 2. 학생 B: 나중에 stale branch가 되도록 PR 만들기

학생 B도 같은 저장소를 clone한 뒤 진행합니다.

```bash
git clone <repo-url>
cd git-collab-capstone
git switch -c feature/b-release-note
```

수정 내용은 아래로 고정합니다.

- `docs/release-checklist.md`의 같은 줄 `- reviewer: TBD`를 `- reviewer: Student B`로 변경
- `config.txt` 맨 아래에 `RELEASE_NOTE_OWNER=Student B` 한 줄 추가

그다음 commit과 push를 진행합니다.

```bash
git add .
git commit -m "Prepare release note update"
git push -u origin feature/b-release-note
```

이후 GitHub에서 `feature/b-release-note -> main` PR을 생성합니다.

### 3. 학생 A PR을 먼저 merge해 conflict 조건 만들기

강사는 학생 A PR을 먼저 merge합니다. merge 방식은 GitHub 기본 `merge commit`으로 통일합니다.

관찰:

- 학생 A PR은 clean merge여야 합니다.
- 이 순간 `main`은 학생 B가 branch를 딸 때 보던 상태보다 앞서 나가게 됩니다.

### 4. 학생 B: local에서 최신 `main`을 반영하고 conflict 해결하기

학생 B는 자신의 로컬 branch에서 최신 `main`을 반영합니다. 이번 capstone에서는 `rebase`가 아니라 `merge`를 기본 경로로 씁니다.

```bash
git fetch origin
git switch feature/b-release-note
git merge origin/main
```

이 단계에서 `docs/release-checklist.md`에 conflict가 나야 합니다. 최종 결과는 아래 한 줄로 정리합니다.

```text
- reviewer: Student A and Student B
```

그다음 해결을 마무리합니다.

```bash
git add docs/release-checklist.md
git commit
git push
```

GitHub PR이 clean 상태로 갱신되면 학생 B PR도 merge합니다.

### 5. 마지막 10분: debrief와 optional revert

강사는 아래 질문으로 정리합니다.

- 왜 학생 A PR은 clean이었고, 학생 B PR은 나중에 conflict가 났는가
- `git fetch origin`은 무엇을 했고, `git merge origin/main`은 무엇을 했는가
- 왜 이번 capstone에서는 `rebase`보다 `merge`를 기본으로 택했는가
- 같은 상황에서 학생 B가 `rebase`를 했다면 왜 force push 논의가 필요해졌을까

시간이 남으면 잘못 merge된 commit 하나를 `revert`하는 짧은 확장 실습도 붙일 수 있습니다.

```bash
git switch -c revert/demo main
git revert <잘못된 commit hash>
git push -u origin revert/demo
```

이후 GitHub에서 `revert/demo -> main` PR을 올려 “협업 브랜치에서는 왜 `revert`가 더 안전한가”를 연결합니다.

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- GitHub 협업 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- 이 시나리오는 local sandbox가 아니라 실제 remote 상태가 계속 바뀐다는 점이 핵심입니다.
- GitHub의 conflict 표시는 local branch가 낡아졌다는 사실의 다른 표현일 뿐입니다.
- `git fetch`는 remote 상태를 가져오지만 현재 branch를 바꾸지 않고, `git merge origin/main`이 실제 branch 갱신을 만듭니다.
- 이번 capstone에서는 `merge`를 택했기 때문에 conflict 해결 뒤 일반 `push`만으로 흐름을 이어갈 수 있습니다.

## 핵심 개념

- 로컬에서 배운 `merge`, `conflict`, `revert` 개념은 remote 협업에서도 그대로 이어집니다.
- 다만 협업에서는 “내 branch가 얼마나 최신 `main`과 멀어졌는가”가 매우 중요합니다.
- PR은 GitHub UI 기능이지만, 그 밑바닥의 충돌 해결은 여전히 로컬 Git 명령이 담당합니다.

## 자주 헷갈리는 포인트

- GitHub에서 conflict가 보인다고 해서 GitHub 화면에서만 해결해야 하는 것은 아닙니다. 이번 시나리오는 local 해결을 기본으로 합니다.
- `git fetch`만으로는 현재 branch가 최신화되지 않습니다.
- 학생 B가 `rebase`를 선택하면 원격 branch history를 다시 쓰게 되어 흐름이 복잡해질 수 있습니다.
- 이 capstone은 현재 워크숍에서 유일하게 `reset-lab`을 쓰지 않는 시나리오입니다.
- 이 시나리오는 생성된 실습 저장소가 아니므로 `git lg` alias가 없을 수 있습니다. 그래프 확인은 `git log --graph --decorate --oneline --all`로 대신합니다.

## 비교 대상

- [03-conflict](../03-conflict/README.md): local에서 conflict marker를 읽고 해결하는 기본 감각을 익힙니다.
- [06-rebase](../06-rebase/README.md): 최신 `main` 반영을 `rebase`로 했을 때 어떤 차이가 생기는지 비교할 수 있습니다.
- [09-revert](../09-revert/README.md): 공유된 히스토리를 안전하게 되돌리는 협업용 기본 규칙입니다.

## 질문 거리

1. 왜 학생 A PR은 clean merge였는데 학생 B PR은 충돌이 났을까요?
2. `git fetch origin`과 `git merge origin/main`은 각각 무엇을 한 걸까요?
3. 왜 이 capstone에서는 `rebase`보다 `merge`를 기본 경로로 택했을까요?
4. 협업 브랜치에서 잘못된 merge를 취소할 때 `reset`보다 `revert`가 더 안전한 이유는 무엇일까요?
