#!/bin/bash

# Initialize Git configuration
# 
# NOTE: the ~/.gitconfig file itself is copied automatically by VSCode from your
# real $HOME, we do not need to include it in the dotfiles repository

set -euo pipefail

# trust the /workspaces directory in Git, avoid adding duplicate entries
if ! git config --global --get-all safe.directory | grep -qxF /workspaces; then
  git config --global --add safe.directory /workspaces
fi
