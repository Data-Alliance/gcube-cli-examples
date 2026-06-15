#!/bin/bash
set -e

COMFYUI_DIR="/workspace/ComfyUI"
MODEL_BASE="${COMFYUI_DIR}/models"

download_url() {
    local url="$1"
    local folder="$2"
    local file_name
    file_name=$(basename "$url" | cut -d'?' -f1)
    local target="${MODEL_BASE}/${folder}/${file_name}"

    if [ -f "$target" ]; then
        echo "[ SKIP  ] ${folder}/${file_name} (이미 존재)"
        return 0
    fi

    echo "[ DOING ] ${folder}/${file_name}"
    wget -q --show-progress -O "$target" "$url"
    echo "[ OK    ] ${folder}/${file_name}"
}

echo "[ START ] Z-Image-Turbo 모델 다운로드"

download_url \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors" \
    "text_encoders"

download_url \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors" \
    "diffusion_models"

download_url \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors" \
    "vae"

echo "[ DONE  ] 모델 다운로드 완료"

echo "[ START ] ComfyUI 서비스 시작 (0.0.0.0:8188)"
cd "$COMFYUI_DIR"
exec python3 main.py --listen 0.0.0.0 --port 8188
