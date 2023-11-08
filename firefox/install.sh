#!/bin/bash

# user editable variables start herw

name="Matthew"

# end

firefoxPath="firefox"

# install the program
# firefox
if command -v apt-get &> /dev/null; then
    echo "APT package manager detected"
elif command -v yum &> /dev/null; then
    echo "YUM package manager detected"
elif command -v pacman &> /dev/null; then
    sudo pacman -S firefox
elif command -v winget &> /dev/null; then
    winget install -e --id Mozilla.Firefox
    firefoxPath="C:\\Program Files\\Mozilla Firefox\\firefox.exe"
else
    echo "Unknown package manager or not installed"
fi

# create firefox profile
eval "$firefoxPath -CreateProfile \"$name $PWD/dotfiles\""
echo "Select custom profile"
eval "$firefoxPath -P"
read -n 1 -s -r -p "Press any key to continue"
echo

# symbolic-link of config
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # linux
    ln -sf $PWD/savedProfile/* $PWD/dotfiles/
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo $OSTYPE
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo $OSTYPE
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    ln -sf "$PWD\\savedProfile\\*" "$PWD\\dotfiles\\" 
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    echo $OSTYPE
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    echo $OSTYPE
else
    echo "Unknown:" $OSTYPE
fi
