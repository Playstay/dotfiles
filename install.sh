#!/usr/bin/sh

# Check ruby was installed
if ! which ruby > /dev/null; then
        echo "This installer needs ruby"
        echo "Please install ruby before run this installer"
        exit 1
fi

# Symlink dotfiles
cd ./bin
ruby install.rb $@
cd ../

# Install dependency repository if user needs
echo "These dotfiles are needs:"
echo "zplug"
echo "fzf"

