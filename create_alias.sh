#!/bin/bash

ALIAS_NAME="primo"
ALIAS_COMMAND="docker compose run --rm"
c_shell=$SHELL

if [ -n "$ZSH_VERSION"] ;then
    CONFIG_FILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    echo "Error: Shell not supported"
    exit 1
fi

if grep -q "^alias $ALIAS_NAME=\"$ALIAS_COMMAND\"" "$CONFIG_FILE";then
    echo "alias already exists"
else
    echo "alias $ALIAS_NAME=\"$ALIAS_COMMAND\"" >> $CONFIG_FILE
    $SHELL && source "$CONFIG_FILE"
fi
