# NVIDIA CUDA base image for GPU support
# Using CUDA 12.1 for better PyTorch compatibility
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

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

# Install PyTorch 2.2.0 with CUDA 12.1 support (meets Boltz2 requirement of torch>=2.2)
RUN pip install torch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 --index-url https://download.pytorch.org/whl/cu121

# Install Boltz2 from PyPI
RUN pip install boltz -U

# Copy samples directory
COPY samples /app/samples

# Create output directory
RUN mkdir -p /app/output

# Set working directory to app root
WORKDIR /app

# Default command
CMD ["bash"]