#!/bin/bash

# Build script for Boltz2 Docker image

echo "Building Boltz2 Docker image with GPU support..."

# Build the Docker image
docker build -t boltz2-gpu:latest .

if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    echo "Image name: boltz2-gpu:latest"
else
    echo "Error: Docker build failed"
    exit 1
fi