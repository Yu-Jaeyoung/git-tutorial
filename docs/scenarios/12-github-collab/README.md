# github-collab

한 줄 요약: 실제 GitHub remote를 두고 2명이 branch, PR, merge, rebase, revert, history rewrite 이후 push 거절까지 한 번에 경험하는 협업 캡스톤입니다.

- 비교 시나리오: [03-conflict](../03-conflict/README.md), [06-rebase](../06-rebase/README.md), [07-interactive-rebase](../07-interactive-rebase/README.md), [09-revert](../09-revert/README.md)

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

### 4. 학생 B: merge 경로로 최신 `main`을 반영하고 conflict 해결하기

학생 B는 자신의 로컬 branch에서 최신 `main`을 반영합니다. 이번 capstone에서는 `rebase`가 아니라 `merge`를 기본 경로로 씁니다. 비교 실습을 위해 stale 상태의 복사 branch도 하나 남겨 둡니다.

```bash
git fetch origin
git switch feature/b-release-note
git branch demo/b-release-note-rebase
git push -u origin demo/b-release-note-rebase
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

### 5. 확장 1: 같은 stale branch를 `rebase`로 다시 풀어 보기

위 단계에서 따로 남겨 둔 `demo/b-release-note-rebase`는 아직 학생 A merge 이전의 stale 상태를 가리키고 있습니다. 이번에는 같은 상황을 `rebase`로 풀어 봅니다.

```bash
git fetch origin
git switch demo/b-release-note-rebase
git rebase origin/main
```

이 단계에서도 같은 줄에서 conflict가 나야 합니다. 최종 줄은 merge 실습과 동일하게 정리합니다.

```text
- reviewer: Student A and Student B
```

그다음 rebase를 마무리합니다.

```bash
git add docs/release-checklist.md
git rebase --continue
git log --graph --decorate --oneline --all
git push
```

여기서 일반 `git push`는 보통 거절됩니다. 이유는 `demo/b-release-note-rebase`가 이미 remote에 올라가 있었고, rebase 후에는 같은 내용처럼 보여도 commit hash가 새로 써졌기 때문입니다.

필요하면 아래로 마무리할 수 있습니다.

```bash
git push --force-with-lease origin demo/b-release-note-rebase
```

관찰:

- merge 경로에서는 일반 `push`만으로 이어졌습니다.
- rebase 경로에서는 히스토리 재작성 때문에 force push 논의가 필요해졌습니다.
- conflict는 둘 다 같은 파일에서 났지만, push 단계의 실패 원인은 파일 conflict가 아니라 non-fast-forward 거절입니다.

### 6. 확장 2: merge된 잘못된 PR을 `revert`로 취소하기

공유된 `main`에 잘못된 PR이 merge됐다고 가정하고, 이번에는 history rewrite 없이 안전하게 취소하는 흐름을 확인합니다.

먼저 학생 A가 의도적으로 잘못된 PR 하나를 만듭니다.

```bash
git fetch origin
git switch -c feature/a-bad-notice origin/main
```

수정 내용:

- `docs/release-checklist.md`의 `- customer notice: draft`를 `- customer notice: send immediately without review`로 변경

그다음 push와 PR을 만듭니다.

```bash
git add docs/release-checklist.md
git commit -m "Change customer notice without review"
git push -u origin feature/a-bad-notice
```

GitHub에서 `feature/a-bad-notice -> main` PR을 merge합니다. merge 방식은 계속 GitHub 기본 merge commit을 씁니다.

이제 학생 B가 그 merge commit을 되돌리는 branch를 만듭니다.

```bash
git fetch origin
git switch -c revert/demo origin/main
git log --graph --decorate --oneline --all
git revert -m 1 <잘못 merge된 PR의 merge commit hash>
git push -u origin revert/demo
```

이후 GitHub에서 `revert/demo -> main` PR을 생성하고 merge합니다.

관찰:

- 기존 잘못된 merge commit은 그래프에 남아 있습니다.
- 그 뒤에 “이 merge를 취소하는” 새 revert commit이 추가됩니다.
- 협업 브랜치에서는 `reset`보다 `revert`가 더 안전하다는 이유가 여기서 드러납니다.

### 7. 확장 3: merge commit이 있는 branch를 `interactive rebase`로 평평하게 만든 뒤 push 거절 보기

이번에는 remote에 이미 올라간 branch의 merge commit을 `interactive rebase`로 지웠을 때 무슨 일이 생기는지 확인합니다.

먼저 merge commit이 있는 전용 demo branch를 만듭니다.

```bash
git fetch origin
git switch -c demo/merge-history-rewrite origin/main
printf '\nHISTORY_REWRITE_DEMO=yes\n' >> app.txt
git commit -am "Add history rewrite marker"
git switch -c demo/merge-helper origin/main
printf '\n- helper note for merge rewrite demo\n' >> README.md
git commit -am "Add helper note for merge rewrite"
git switch demo/merge-history-rewrite
git merge --no-ff demo/merge-helper -m "Merge helper branch for history demo"
git push -u origin demo/merge-history-rewrite
git log --graph --decorate --oneline --all
```

이제 같은 branch에서 기본 interactive rebase를 실행합니다.

```bash
git rebase -i HEAD~2
```

편집기에서는 기본 `pick` 상태로 그대로 저장하고 종료합니다. merge commit이 포함된 범위를 기본 `-i`로 다시 쓰면, merge topology가 평평해지면서 merge commit이 사라질 수 있습니다.

rebase가 끝나면 그래프를 다시 봅니다.

```bash
git log --graph --decorate --oneline --all
git push
```

이 `git push`는 보통 거절됩니다. 중요한 점은 이것이 파일 conflict가 아니라, remote branch가 여전히 예전 merge commit을 포함한 히스토리를 가지고 있기 때문이라는 점입니다.

즉:

- local 그래프에서는 merge commit이 없어졌습니다.
- remote 그래프에는 아직 merge commit이 남아 있습니다.
- Git 입장에서는 fast-forward가 아니라 history rewrite이므로 일반 `push`를 막습니다.

이후 선택지는 두 가지입니다.

- 교육용 관찰만 하고 멈춘다.
- 팀과 합의된 상황에서만 `git push --force-with-lease origin demo/merge-history-rewrite`를 시도한다.

복구까지 연결하고 싶다면 [07-interactive-rebase](../07-interactive-rebase/README.md)의 `reflog` 복구 절차를 같이 봅니다.

### 8. 마지막 10분: debrief

강사는 아래 질문으로 정리합니다.

- 왜 학생 A PR은 clean이었고, 학생 B PR은 나중에 conflict가 났는가
- `git fetch origin`은 무엇을 했고, `git merge origin/main`은 무엇을 했는가
- 왜 merge 경로에서는 일반 `push`가 가능했고, rebase 경로에서는 force push 논의가 생겼는가
- merge commit이 있는 branch를 기본 `interactive rebase`로 다시 쓰면 왜 remote와 충돌하는가
- 잘못 merge된 PR을 취소할 때 왜 `reset`보다 `revert`가 더 안전한가

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- GitHub 협업 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- 이 시나리오는 local sandbox가 아니라 실제 remote 상태가 계속 바뀐다는 점이 핵심입니다.
- GitHub의 conflict 표시는 local branch가 낡아졌다는 사실의 다른 표현일 뿐입니다.
- `git fetch`는 remote 상태를 가져오지만 현재 branch를 바꾸지 않고, `git merge origin/main`이나 `git rebase origin/main`이 실제 branch 갱신을 만듭니다.
- merge 경로는 기존 공유 히스토리를 보존하므로 일반 `push`로 이어지기 쉽습니다.
- rebase나 interactive rebase는 commit hash를 다시 쓰기 때문에 push 단계에서 non-fast-forward 거절을 직접 볼 수 있습니다.

## 핵심 개념

- 로컬에서 배운 `merge`, `conflict`, `rebase`, `revert`, `interactive rebase` 개념은 remote 협업에서도 그대로 이어집니다.
- 다만 협업에서는 “내 branch가 얼마나 최신 `main`과 멀어졌는가”와 “내가 히스토리를 다시 썼는가”가 매우 중요합니다.
- PR은 GitHub UI 기능이지만, 그 밑바닥의 충돌 해결과 history rewrite 판단은 여전히 로컬 Git 명령이 담당합니다.

## 자주 헷갈리는 포인트

- GitHub에서 conflict가 보인다고 해서 GitHub 화면에서만 해결해야 하는 것은 아닙니다. 이번 시나리오는 local 해결을 기본으로 합니다.
- `git fetch`만으로는 현재 branch가 최신화되지 않습니다.
- `rebase` 뒤의 `git push` 거절은 파일 conflict가 아니라 history rewrite로 인한 non-fast-forward 거절입니다.
- GitHub 기본 merge commit을 되돌릴 때는 `git revert -m 1 <merge-commit-hash>`처럼 `-m`이 필요할 수 있습니다.
- merge commit을 평평하게 만든 뒤 일반 `push`가 거절되더라도, 그 자체가 곧 force push를 뜻하는 것은 아닙니다. 먼저 왜 거절됐는지 설명할 수 있어야 합니다.
- 이 capstone은 현재 워크숍에서 유일하게 `reset-lab`을 쓰지 않는 시나리오입니다.
- 이 시나리오는 생성된 실습 저장소가 아니므로 `git lg` alias가 없을 수 있습니다. 그래프 확인은 `git log --graph --decorate --oneline --all`로 대신합니다.

## 비교 대상

- [03-conflict](../03-conflict/README.md): local에서 conflict marker를 읽고 해결하는 기본 감각을 익힙니다.
- [06-rebase](../06-rebase/README.md): 최신 `main` 반영을 `rebase`로 했을 때 어떤 차이가 생기는지 비교할 수 있습니다.
- [07-interactive-rebase](../07-interactive-rebase/README.md): merge commit을 평평하게 만들었을 때 왜 remote push가 까다로워지는지 연결할 수 있습니다.
- [09-revert](../09-revert/README.md): 공유된 히스토리를 안전하게 되돌리는 협업용 기본 규칙입니다.

## 질문 거리

1. 왜 학생 A PR은 clean merge였는데 학생 B PR은 충돌이 났을까요?
2. `git fetch origin`, `git merge origin/main`, `git rebase origin/main`은 각각 무엇을 한 걸까요?
3. 왜 merge 경로는 일반 `push`가 가능했고, rebase 경로는 force push 논의를 만들었을까요?
4. merge commit을 기본 interactive rebase로 다시 쓴 뒤 `git push`가 거절되는 이유는 무엇일까요?
5. 이때의 `push` 거절은 파일 conflict와 어떻게 다를까요?
6. 협업 브랜치에서 잘못된 merge를 취소할 때 `reset`보다 `revert`가 더 안전한 이유는 무엇일까요?
