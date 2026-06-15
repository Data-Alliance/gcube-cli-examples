FROM pytorch/pytorch:2.7.0-cuda12.8-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# pip 패키지 한 RUN으로 묶어 레이어 최소화 + 캐시/잔여물 정리로 이미지 경량화
RUN pip install --no-cache-dir \
        jupyterlab \
        numpy \
        pandas \
        matplotlib \
        transformers \
        datasets \
 && rm -rf /root/.cache /tmp/* /var/lib/apt/lists/*

WORKDIR /workspace

EXPOSE 8888

CMD ["sh", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token=\"${JUPYTER_TOKEN:-}\" --ServerApp.password=\"\" --ServerApp.allow_origin='*' --ServerApp.root_dir=/workspace"]
