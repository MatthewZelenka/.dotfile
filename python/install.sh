#!/bin/bash

if command -v apt-get &> /dev/null; then
    echo "APT package manager detected"
elif command -v yum &> /dev/null; then
    echo "YUM package manager detected"
elif command -v pacman &> /dev/null; then
    sudo pacman -S python pyright
elif command -v winget &> /dev/null; then
    winget install -e --id Python.Python.3.11
    if command -v python &> /dev/null; then
        pip install pyright
    else
        echo "Can not install pyright. Python not installed"
    fi
else
    echo "Unknown package manager or not installed"
fi

