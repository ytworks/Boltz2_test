# NVIDIA CUDA base image for GPU support
FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Create and activate virtual environment
RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/venv"

# Upgrade pip and install setuptools
RUN pip install --upgrade pip setuptools wheel

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