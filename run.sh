#!/bin/bash

# Run script for Boltz2 predictions in Docker

# Default values
INPUT_FILE="samples/affinity.yaml"
OUTPUT_DIR="output"
USE_MSA_SERVER=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input)
            INPUT_FILE="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --use-msa-server)
            USE_MSA_SERVER="--use_msa_server"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  -i, --input FILE      Input YAML file (default: samples/affinity.yaml)"
            echo "  -o, --output DIR      Output directory (default: output)"
            echo "  --use-msa-server      Use MSA server for predictions"
            echo "  -h, --help           Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Get absolute paths
ABS_INPUT_FILE=$(realpath "$INPUT_FILE")
ABS_OUTPUT_DIR=$(realpath "$OUTPUT_DIR")

echo "Running Boltz2 prediction..."
echo "Input: $INPUT_FILE"
echo "Output: $OUTPUT_DIR"

# Run Docker container with GPU support and increased shared memory
docker run --rm \
    --gpus all \
    --shm-size=10.13gb \
    --ipc=host \
    -v "$ABS_INPUT_FILE:/app/input.yaml:ro" \
    -v "$ABS_OUTPUT_DIR:/app/output" \
    boltz2-gpu:latest \
    bash -c "boltz predict /app/input.yaml --out_dir /app/output $USE_MSA_SERVER"

if [ $? -eq 0 ]; then
    echo "Prediction completed successfully!"
    echo "Results saved in: $OUTPUT_DIR"
else
    echo "Error: Prediction failed"
    exit 1
fi