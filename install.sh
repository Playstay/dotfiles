#!/bin/sh

# Check ruby was installed
if ! which ruby > /dev/null 2>&1; then
        echo "This installer needs ruby."
        echo "Please install ruby before run this installer."
        exit 1
fi

# Symlink dotfiles
cd ./bin
ruby install.rb $@
cd ../

# Install dependency repository if user needs
# FIXME: Auto generate these massages
echo "These dotfiles are needs:"
echo "\tzplug"
echo "\tfzf"
echo "\tmsgpack"
