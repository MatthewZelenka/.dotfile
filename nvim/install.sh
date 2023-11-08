#!/bin/bash

# install the program
# nvim pyright, lua_lsp, ripgrep, lazy vim at the start
if command -v apt-get &> /dev/null; then
    echo "APT package manager detected"
elif command -v yum &> /dev/null; then
    echo "YUM package manager detected"
elif command -v pacman &> /dev/null; then
    sudo pacman -S neovim lua-language-server ripgrep
elif command -v winget &> /dev/null; then
    winget install -e --id Neovim.Neovim
    winget install -e --id LuaLS.lua-language-server    
    winget install -e --id BurntSushi.ripgrep.MSVC 
else
    echo "Unknown package manager or not installed"
fi

# symbolic-link of config
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # linux
    ln -sf $PWD/nvim ~/.config/
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo $OSTYPE
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo $OSTYPE
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    mklink "$PWD/nvim" "C:/Users/%USERPROFILE%/AppData/Local/nvim/"
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    echo $OSTYPE
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    echo $OSTYPE
else
    echo "Unknown:" $OSTYPE
fi
