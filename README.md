# Boltz2 Docker Environment

RTX5090対応のBoltz2実行環境です。

## 必要な環境

- Docker
- NVIDIA Docker runtime (nvidia-docker2)
- NVIDIA GPU (RTX5090)

## 使用方法

### 1. Dockerイメージのビルド

```bash
./build.sh
```

### 2. Boltz2の実行

基本的な使い方:
```bash
./run.sh
```

オプション指定:
```bash
# 入力ファイルを指定
./run.sh -i samples/affinity.yaml

# 出力ディレクトリを指定
./run.sh -o results

# MSAサーバーを使用
./run.sh --use-msa-server

# ヘルプを表示
./run.sh -h
```

## ファイル構成

- `Dockerfile`: GPU対応のDocker環境定義
- `build.sh`: Dockerイメージビルドスクリプト
- `run.sh`: Boltz2実行スクリプト
- `samples/affinity.yaml`: サンプル入力ファイル

## 技術仕様

- ベースイメージ: NVIDIA CUDA 12.1.0 with cuDNN8
- Python環境管理: python3-venv
- Boltz2: PyPIから最新版をインストール