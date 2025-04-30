#!/bin/bash

ARCH=$(uname -m)
OS=$(uname -s)
VERSION=v0.0.102
if [ "$OS" = "Linux" ]; then
    OS=linux
elif [ "$OS" = "Darwin" ]; then
    OS=darwin
else
    echo "Error: Unsupported operating system '$OS'"
    exit 1
fi

if [ "$ARCH" = "x86_64" ]; then
    ARCH=amd64
elif [[ "$ARCH" = "aarch64" || "$ARCH" = "arm64" ]]; then
    ARCH=arm64
else 
    echo "Error: Unsupported architecture '$ARCH'"
    exit 1
fi

rm tdfs_${OS}_${ARCH}.tar.gz 2> /dev/null

echo "Downloading https://github.com/2DFS/2dfs-builder/releases/download/$VERSION/tdfs_${OS}_${ARCH}.tar.gz"
curl -L -O "https://github.com/2DFS/2dfs-builder/releases/download/$VERSION/tdfs_${OS}_${ARCH}.tar.gz"
if [ $? -ne 0 ]; then
        echo "Error: Failed to retrieve the latest tdfs release."
        exit 1
fi

tar -xzf tdfs_${OS}_${ARCH}.tar.gz
if [ "$(uname)" == "Darwin" ]; then
    mv tdfs ~/bin/tdfs     
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo mv tdfs /usr/local/bin/tdfs
fi

rm tdfs_${OS}_${ARCH}.tar.gz 2> /dev/null

if [ $? -ne 0 ]; then
        echo "Error: Failed to install the latest tdfs release."
        exit 1
fi

echo ✅ tdfs CLI installation complete
