# PyTorch + JupyterLab 배포 예시

Claude Code + SPEC.md 방식으로 gcube 에 PyTorch + JupyterLab 환경을 배포하는 예시입니다.

## 구성 파일

| 파일 | 내용 |
|---|---|
| `CLAUDE.md` | Claude Code 가 시작 시 자동 인식하는 환경 정보 |
| `SPEC.md` | 작업 상세 명세 (베이스 이미지·패키지·workload 설정) |
| `Dockerfile` | 빌드된 이미지 정의 |
| `.github/workflows/build.yml` | GitHub Actions 빌드 워크플로 (수동 트리거) |
| `workload.yaml` | gcube 워크로드 등록용 yml |
| `README.md` | 본 문서 |


## 환경 사양

| 항목 | 값 |
|---|---|
| 베이스 이미지 | `pytorch/pytorch:2.7.0-cuda12.8-cudnn9-runtime` |
| 추가 패키지 | jupyterlab, numpy, pandas, matplotlib, transformers, datasets 등 |
| GPU | RTX 3070 (gpuCode 101, Tier 3) |
| 포트 | 8888 (JupyterLab) |
| CUDA | 12080 |


## 사용법

### 1. 본인 정보로 정정

`CLAUDE.md` · `SPEC.md` 에서 다음을 본인 값으로 정정합니다:

- `username` → 본인 GitHub username
- repo 이름 (`gcube-pytorch-jupyter`) → 원하는 이름으로 변경 가능

### 2. Claude Code 실행

작업 폴더에서 Claude Code 를 실행하고 다음을 입력합니다:

```
SPEC.md 따라 작업 진행해줘
```

### 3. 결과물 확인 + GitHub push

Claude Code 가 다음 파일들을 작성합니다:

- `Dockerfile`
- `.github/workflows/build.yml`
- `README.md`
- `workload.yaml`

본인 GitHub 에 repo 생성 후 push 합니다.

### 4. 이미지 빌드 (수동 트리거)

GitHub repo 의 **Actions** 탭 → "Build and Push Docker Image" 선택 → **Run workflow** 버튼 클릭.

빌드 완료 후 `ghcr.io/<username>/<repo>:latest` 에 이미지가 푸시됩니다.

### 5. gcube 워크로드 배포

```bash
gcube workload register -f workload.yaml
gcube workload start <SER>
gcube workload describe <SER>
```

상태가 `deploy` 가 되면 정상 배포 완료.


## 참고

- 본 예시는 ghcr public 이미지 기준입니다. private 이미지의 경우 `gcube credential` 명령으로 GitHub 자격 증명을 별도 등록해야 합니다.
- 작성 시점(2026-05)의 gcube CLI 기준이며, 추후 업데이트 예정입니다.
