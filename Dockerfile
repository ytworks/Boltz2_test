# NVIDIA CUDA base image for GPU support
FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV UV_SYSTEM_PYTHON=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Create working directory
WORKDIR /app

# Create and activate virtual environment with uv
RUN uv venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/venv"

# Install Python and pip in the virtual environment
RUN uv pip install --upgrade pip setuptools wheel

# Install Boltz2 from PyPI
RUN uv pip install boltz -U

# Copy samples directory
COPY samples /app/samples

# Create output directory
RUN mkdir -p /app/output

# Set working directory to app root
WORKDIR /app

# Default command
CMD ["bash"]