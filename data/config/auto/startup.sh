#!/bin/bash

# Change directory to the extensions folder
cd ./extensions

# Array of GitHub repository URLs
repositories=(
    "https://github.com/kohya-ss/sd-webui-additional-networks.git"
    "https://github.com/Mikubill/sd-webui-controlnet.git"
    "https://github.com/huchenlei/sd-webui-openpose-editor.git"
    "https://github.com/wywywywy/sd-webui-depth-lib.git"
    "https://github.com/hnmr293/posex.git"
    "https://github.com/nonnonstop/sd-webui-3d-open-pose-editor.git"
    "https://github.com/camenduru/sd-webui-tunnels.git"
    "https://github.com/catppuccin/stable-diffusion-webui.git"
    "https://github.com/AUTOMATIC1111/stable-diffusion-webui-rembg.git"
    "https://github.com/ashen-sensored/stable-diffusion-webui-two-shot.git"
    "https://github.com/xhoxye/sd-webui-ar_xhox.git"
    "https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git"
    "https://github.com/mix1009/model-keyword"
    "https://github.com/adieyal/sd-dynamic-prompts.git"
    "https://github.com/Seshelle/CFG_Rescale_webui.git"
    "https://github.com/hako-mikan/sd-webui-negpip.git"
    "https://github.com/hako-mikan/sd-webui-regional-prompter.git"
    "https://github.com/kousw/stable-diffusion-webui-daam.git"
)

# Function to clone repositories if directories don't exist
clone_repositories() {
    for repo in "${repositories[@]}"; do
        repo_name=$(basename "$repo" .git)
        if [ ! -d "$repo_name" ]; then
            if ! git clone --depth 1 "$repo"; then
                echo "Failed to clone $repo"
                exit 1
            fi
        else
            echo "Directory $repo_name already exists. Skipping clone."
        fi
    done
}

# Clone repositories if directories don't exist
clone_repositories

# Install Python package
# /opt/conda/bin/python -m pip install 'insightface'

# exit 0
