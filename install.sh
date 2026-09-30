#!/usr/bin/env bash

set -e

# Determine the absolute path to the dotfiles directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$ROOT_DIR/dotfiles"
BACKUP_SUFFIX=".backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR to $HOME..."

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: Directory $DOTFILES_DIR does not exist."
  exit 1
fi

cd "$DOTFILES_DIR"

# Iterate over all files in the dotfiles directory
find . -type f | while read -r file; do
  # Remove leading './'
  rel_file="${file#./}"
  target_file="$HOME/$rel_file"
  target_dir="$(dirname "$target_file")"

  # Create target directory if it doesn't exist
  mkdir -p "$target_dir"

  # Check if target file already exists
  if [ -e "$target_file" ] || [ -h "$target_file" ]; then
    # If the files are identical, skip
    if cmp -s "$file" "$target_file"; then
      echo "Skipping $rel_file (already up to date)"
      continue
    fi

    # Backup the existing different file
    backup_file="${target_file}${BACKUP_SUFFIX}"
    echo "Backing up existing $rel_file -> $backup_file"
    mv "$target_file" "$backup_file"
  fi

  # Copy the new file, preserving permissions
  echo "Copying $rel_file -> $target_file"
  cp -p "$file" "$target_file"
done

SCRIPTS_DIR="$ROOT_DIR/scripts"
if [ -d "$SCRIPTS_DIR" ]; then
  echo "Running scripts from $SCRIPTS_DIR..."
  find "$SCRIPTS_DIR" -type f | sort | while read -r script; do
    if [ -x "$script" ]; then
      echo "Executing $script..."
      "$script"
    else
      echo "Skipping $script (not executable)"
    fi
  done
fi

echo "Dotfiles installation complete!"
