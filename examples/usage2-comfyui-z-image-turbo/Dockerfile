# CUDA 12.9 + cuDNN + Ubuntu 22.04
# gcube 표준 환경 (CUDA 12.9). 태그 존재 확인 완료
# 출처: https://hub.docker.com/r/nvidia/cuda/tags
FROM nvidia/cuda:12.9.0-cudnn-runtime-ubuntu22.04

LABEL maintainer="username"
LABEL purpose="ComfyUI + Z-Image-Turbo deployment on gcube"

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# 시스템 패키지: Python·git·wget
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 python3-pip python3-venv \
        git wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip

# ComfyUI clone
# 출처: https://github.com/comfyanonymous/ComfyUI
WORKDIR /workspace
RUN git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /workspace/ComfyUI

# PyTorch CUDA 12.8 wheel (RTX 5060Ti Blackwell sm_120 지원)
# 출처: https://pytorch.org/get-started/locally/
RUN pip install --no-cache-dir torch torchvision torchaudio \
        --index-url https://download.pytorch.org/whl/cu128

# ComfyUI 의존성
RUN pip install --no-cache-dir -r requirements.txt

# ComfyUI-Manager 설치
# 출처: https://github.com/Comfy-Org/ComfyUI-Manager
RUN git clone --depth 1 https://github.com/Comfy-Org/ComfyUI-Manager.git \
        custom_nodes/comfyui-manager \
    && pip install --no-cache-dir -r custom_nodes/comfyui-manager/requirements.txt

# 첫 기동 시 사용할 디렉토리 사전 생성
# user/default: ComfyUI v0.21+ userdata 404 오류 회피
RUN mkdir -p models/text_encoders models/diffusion_models models/vae \
    && mkdir -p user/default

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8188

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
