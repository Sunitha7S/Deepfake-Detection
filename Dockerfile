# CPU-only Dockerfile for Deepfake-Detection (place at .devcontainer/Dockerfile)
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# System dependencies + build tools + ffmpeg + python3 + boost (helps dlib)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake git wget unzip ffmpeg \
    libsm6 libxrender1 libxext6 libgl1-mesa-glx ca-certificates \
    python3 python3-dev python3-pip python3-venv curl \
    libboost-all-dev \
 && rm -rf /var/lib/apt/lists/*

# Ensure pip and wheel tools are up-to-date
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install a few core Python packages to reduce later time
RUN pip3 install numpy scipy pillow opencv-python==4.2.0.32

# Create a non-root developer user and use it by default
RUN useradd -m developer
USER developer
WORKDIR /home/developer/workspace

# Default command: open a bash shell
ENTRYPOINT ["/bin/bash"]