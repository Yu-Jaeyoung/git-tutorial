# tag

한 줄 요약: `tag`는 특정 commit에 붙이는 고정된 이름표로, release 지점이나 복구 기준점을 사람 읽기 쉬운 이름으로 남길 때 유용합니다.

- 비교 시나리오: [10-reset](../10-reset/README.md)

## 언제 쓰는가

- 배포하거나 공유할 특정 commit에 움직이지 않는 이름을 붙이고 싶을 때
- 나중에 “어느 commit이 v1.0.0이었는가”를 branch 이름보다 더 안정적으로 남기고 싶을 때
- branch와 tag의 차이, detached HEAD를 함께 설명하고 싶을 때

## 시작 상태 만들기

```bash
./bin/reset-lab tag
git switch main
git lg
git tag --list 'release/*'
```

이 실습 저장소는 내부적으로 `scenario/*` 태그를 이미 사용하고 있습니다. 그래서 tag 실습에서는 `release/*` 패턴만 필터링해서 봅니다.

## 실습 절차

### 1. lightweight tag와 annotated tag 만들기

```bash
git tag release/v1.0.0 HEAD~1
git tag -a release/v1.1.0 -m "Release v1.1.0" HEAD
git tag --list 'release/*'
git show --no-patch release/v1.0.0
git show --no-patch release/v1.1.0
```

관찰:

- `release/v1.0.0`은 이전 commit에 붙은 lightweight tag입니다.
- `release/v1.1.0`은 메시지가 있는 annotated tag입니다.
- `git show --no-patch`를 보면 annotated tag는 tag 자체의 메타데이터도 함께 보입니다.

### 2. branch는 움직이고 tag는 그대로인 점 보기

이제 `main`을 한 commit 더 진행시켜 봅니다.

```bash
printf '\nNEXT_RELEASE=prepare-v1.1.1\n' >> config.txt
git commit -am "Prepare next release note"
git rev-parse --short main
git rev-parse --short release/v1.1.0
```

관찰:

- `main`은 새 commit을 가리키지만 `release/v1.1.0`은 그대로입니다.
- 즉 branch는 움직이는 포인터이고, tag는 고정된 이름표입니다.

### 3. tag checkout과 detached HEAD 보기

```bash
git switch --detach release/v1.0.0
git status -sb
git switch main
```

관찰:

- tag를 checkout하면 특정 commit에 직접 서게 되므로 detached HEAD가 됩니다.
- 다시 작업을 이어가려면 branch로 돌아오거나 새 branch를 만들어야 합니다.

### 4. local tag 삭제하기

```bash
git tag -d release/v1.0.0
git tag --list 'release/*'
```

관찰:

- tag 이름표만 사라지고, commit 자체는 지워지지 않습니다.
- 남아 있는 tag 목록을 통해 현재 어떤 release 이름이 유지되는지 바로 볼 수 있습니다.

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- tag 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- branch를 한 commit 더 진행해도 tag는 자동으로 따라가지 않습니다.
- lightweight tag와 annotated tag는 모두 commit을 가리키지만, annotated tag는 추가 메타데이터를 가집니다.
- tag를 checkout하면 detached HEAD가 되는 이유를 상태 출력에서 바로 확인할 수 있습니다.
- 이 저장소는 내부 scenario 태그가 많기 때문에 `git tag --list 'release/*'`처럼 패턴 필터가 중요합니다.

## 핵심 개념

- tag는 “고정된 release 이름표”, branch는 “움직이는 작업 포인터”로 가르치면 가장 이해가 쉽습니다.
- annotated tag는 release 메모나 서명 같은 부가 정보를 남기기 좋습니다.
- tag는 복구 기준점, 배포 지점, 데모 기준 commit을 명시할 때 유용합니다.

## 자주 헷갈리는 포인트

- tag를 만든다고 새 commit이 생기지는 않습니다.
- tag를 지워도 commit은 남습니다.
- tag checkout은 branch checkout이 아니므로 detached HEAD가 됩니다.
- remote에 tag를 올리는 동작은 branch push와 별도로 이해해야 합니다.

## 비교 대상

- [10-reset](../10-reset/README.md): branch 포인터를 뒤로 움직이는 명령입니다. tag는 반대로, 특정 commit에 고정 이름을 붙이는 데 집중합니다.

## 질문 거리

1. 왜 release 지점은 branch보다 tag로 남기는 편이 더 자연스러울까요?
2. lightweight tag와 annotated tag 중 어떤 상황에서 각각 쓰면 좋을까요?
3. tag를 checkout하면 왜 detached HEAD가 되는지 설명할 수 있나요?
4. 이 실습 저장소에서 `git tag --list 'release/*'`처럼 필터링하는 이유는 무엇인가요?
