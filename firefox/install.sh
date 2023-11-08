#!/bin/bash

# user editable variables start herw

name="Matthew"

# end

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
else
    echo "Unknown package manager or not installed"
fi



# symbolic-link of config
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # linux
    # create firefox profile
    firefox -CreateProfile \"$name $PWD/dotfiles\"
    echo "Select custom profile"
    firefox -P
    read -n 1 -s -r -p "Press any key to continue"
    echo
    ln -sf $PWD/savedProfile/* $PWD/dotfiles/
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo $OSTYPE
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo $OSTYPE
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    # create firefox profile
    mkdir "$PWD/dotfiles" 
    /c/Program\ Files/Mozilla\ Firefox/firefox.exe -CreateProfile "$name $(cmd //c cd)/dotfiles"
    echo "Select custom profile"
    /c/Program\ Files/Mozilla\ Firefox/firefox.exe -P
    read -n 1 -s -r -p "Press any key to continue"
    echo
    ln -sf $PWD/savedProfile/* $PWD/dotfiles/
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    echo $OSTYPE
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    echo $OSTYPE
else
    echo "Unknown:" $OSTYPE
fi
