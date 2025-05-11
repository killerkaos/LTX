#!/bin/bash
conda init bash > /proc/1/fd/1
source ~/.bashrc

conda activate /config/venv

echo "=========================================" > /proc/1/fd/1
echo "EXECUTING SERVER" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /config/ComfyUI
python main.py --listen=0.0.0.0 --port=8188 > /proc/1/fd/1
