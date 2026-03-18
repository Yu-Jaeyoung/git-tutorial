# setting

한 줄 요약: `01`부터 `11`까지의 실습은 먼저 전용 Git 샌드박스를 만든 뒤, 그 저장소 안에서 `git lg`와 `./bin/reset-lab`을 기준으로 반복 진행합니다.

## 언제 읽는가

- `01-merge-ff`로 들어가기 전에 처음 한 번 읽습니다.
- 강사용 저장소와 학생용 배포본 중 어떤 시작 경로를 써야 하는지 헷갈릴 때 읽습니다.
- `git lg`, `git status -sb`, `./bin/reset-lab`이 왜 동작하는지 먼저 잡고 싶을 때 읽습니다.
- 마지막 GitHub 협업 capstone인 `12-github-collab`은 이 문서의 예외라는 점을 확인하고 싶을 때 읽습니다.

## 어떤 경로를 쓰는가

강사 또는 자료 작성자라면 이 저장소 루트에서 시작합니다.

```bash
./scripts/setup-workshop-lab.sh
cd generated/git-workshop-lab
```

학생용 배포본을 받았다면 `student-kit/` 안에서 시작합니다.

```bash
cd student-kit
./setup-student-lab.sh
cd generated/git-workshop-lab
```

둘 다 최종적으로는 `generated/git-workshop-lab` 같은 실습용 저장소 안으로 들어간다는 점이 핵심입니다.

## 시작 상태 만들기

실습 저장소 안으로 들어간 뒤 아래 세 명령을 먼저 확인합니다.

```bash
git status -sb
git lg
./bin/reset-lab merge-ff
```

그다음 다시 상태를 봅니다.

```bash
git status -sb
git lg
```

## 명령 참고

- 공통 명령과 표기: [command-reference](../reference/README.md)
- 설정 전용 명령: [COMMANDS.md](./COMMANDS.md)

## 관찰 포인트

- 실습은 이 문서 저장소가 아니라 생성된 실습 저장소 안에서 진행합니다.
- `git lg`와 `./bin/reset-lab`은 실습 저장소를 만들 때 자동으로 설정됩니다.
- 시나리오를 다시 시작하고 싶을 때는 `reset`, `checkout`, 새 clone보다 `./bin/reset-lab <scenario>`가 기본 복구 수단입니다.
- 예외적으로 `12-github-collab`은 실제 GitHub remote를 쓰므로, 이 문서의 local sandbox 규칙을 그대로 따르지 않습니다.

## 핵심 개념

- 이 워크숍은 “실제 작업 저장소”와 “실습용 샌드박스 저장소”를 분리해 두는 방식입니다.
- 그래서 `reset --hard`, `clean`, `rebase`, `interactive rebase` 같은 위험한 명령도 반복 연습하기 쉽습니다.
- `01`부터 `11`까지는 같은 실습 저장소 안에서 시작 상태만 바꿔 가며 진행하고, 마지막 `12-github-collab`만 별도 GitHub 저장소에서 진행합니다.

## 자주 헷갈리는 포인트

- 루트 저장소에서 바로 `git lg`를 치면 실습 alias가 없을 수 있습니다. 반드시 생성된 실습 저장소 안으로 들어가야 합니다.
- `student-kit/`는 배포 패키지이고, 실제 실습은 그 안에서 생성한 별도 Git 저장소에서 합니다.
- `./bin/reset-lab`은 실습 저장소 안에만 있습니다.

## 비교 대상

- [01-merge-ff](../01-merge-ff/README.md): 환경 준비가 끝나면 가장 먼저 들어갈 실습입니다.

## 질문 거리

1. 왜 이 워크숍은 실습용 저장소를 따로 만들어서 진행할까요?
2. `./bin/reset-lab`을 쓰는 방식이 새로 clone하는 방식보다 왜 편할까요?
3. 강사용 setup과 학생용 setup은 어디까지 같고, 어디서 갈라질까요?
