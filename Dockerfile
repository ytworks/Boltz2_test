# NVIDIA CUDA base image for GPU support
# Using CUDA 12.8 for better RTX 5090 support
FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3-pip \
    git \
    curl \
    wget \
    build-essential \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.10 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Create working directory
WORKDIR /app

# Create and activate virtual environment with Python 3.10
RUN python3.10 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/venv"

# Upgrade pip and install setuptools
RUN pip install --upgrade pip setuptools wheel

# First install Boltz2 to get all dependencies
RUN pip install boltz -U

# Then force reinstall PyTorch nightly with CUDA 12.8 support for RTX 5090 (sm_120)
# This will override the PyTorch version installed by Boltz2
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128 --force-reinstall

# Copy samples directory
COPY samples /app/samples

# Create output directory
RUN mkdir -p /app/output

# Set working directory to app root
WORKDIR /app

# Default command
CMD ["bash"]