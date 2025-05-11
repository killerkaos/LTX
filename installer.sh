#!/bin/bash
conda init bash > /proc/1/fd/1
source ~/.bashrc

if [ ! -d /config/venv ]; then
echo "=========================================" > /proc/1/fd/1
echo "CONDA CREATE venv" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
    conda create -p /config/venv python=3.12 -y > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "CONDA ACTIVATE venv" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
    conda activate /config/venv > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "INSTALLING DEPENDENCIES (WILL TAKE A LONG TIME)" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu128 > /proc/1/fd/1
    conda install -y -c "nvidia/label/cuda-12.8.0" cuda-runtime -y > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
echo "DEPENDENCIES ALL INSTALLED" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
fi

if [ ! -d /config/ComfyUI ]; then
echo "=========================================" > /proc/1/fd/1
echo "INSTALLING & Downloading ComfyUI" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /config/
git clone https://github.com/comfyanonymous/ComfyUI.git > /proc/1/fd/1
cd ComfyUI
pip install -r requirements.txt > /proc/1/fd/1
fi

if [ ! -d /config/ComfyUI/comfyui-manager ]; then
echo "=========================================" > /proc/1/fd/1
echo "INSTALLING & Downloading Manager" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /config/ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager
cd comfyui-manager
pip install -r requirements.txt > /proc/1/fd/1
fi

echo "=========================================" > /proc/1/fd/1
echo "FINISH INSTALLATION" > /proc/1/fd/1
echo "=========================================" > /proc/1/fd/1
cd /config/
touch installed
