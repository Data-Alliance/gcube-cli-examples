# ComfyUI + Z-Image-Turbo 배포 예시

Claude Code 스킬 (`gcube-workload-create`) 을 사용해 gcube 에 ComfyUI + Z-Image-Turbo 환경을 배포하는 예시입니다.

## 구성 파일

| 파일 | 내용 |
|---|---|
| `Dockerfile` | ComfyUI + Z-Image-Turbo 환경 이미지 정의 |
| `entrypoint.sh` | 모델 자동 다운로드 + ComfyUI 기동 스크립트 |
| `.github/workflows/build.yml` | GitHub Actions 빌드 워크플로 (수동 트리거) |
| `workload.yml` | gcube 워크로드 등록용 yml |
| `README.md` | 본 문서 |


## 환경 사양

| 항목 | 값 |
|---|---|
| 서비스 | ComfyUI 이미지 생성 |
| 모델 | Z-Image-Turbo 3종 (Comfy-Org 공식 제공) |
| 포트 | ComfyUI 기본 포트 |


## 사용법

### 1. 스킬 설치

저장소 루트의 [스킬 설치 안내](../../README.md#스킬-설치) 참고.

### 2. Claude Code 실행

스킬 등록 후 Claude Code 를 실행하고 자연어로 요청합니다:

```
gcube 에 ComfyUI 워크로드 띄워줘
```

### 3. 4단계 흐름 진행

스킬이 다음 4단계로 함께 진행합니다:

| 단계 | 내용 |
|---|---|
| 01. 정보 수집 | 서비스·모델·자원·결과물 보존 위치 결정 |
| 02. 설계 | 환경변수·마운트·구조 결정 |
| 03. 이미지 제작 | Dockerfile · entrypoint · build.yml 작성 |
| 04. 배포·검증 | workload yml 작성 + 등록 + 동작 확인 |

각 단계에서 스킬이 정보·선택지·근거를 제공하고, 모든 결정은 사용자가 합니다.

### 4. 결과물 활용

본 폴더의 파일들은 한 가지 결과물 예시입니다.

스킬이 사용자 환경·요구에 따라 다른 결과물을 만들 수 있으므로, 본 폴더 파일은 **참고 자료** 로 활용하세요.


## 참고

- ComfyUI 모델은 [Comfy-Org](https://huggingface.co/Comfy-Org) 공식 제공 모델 사용을 권장합니다. 일반 Hugging Face 원본 모델은 ComfyUI 와 호환되지 않을 수 있습니다.
- 작성 시점(2026-05)의 gcube CLI 기준이며, 추후 업데이트 예정입니다.
