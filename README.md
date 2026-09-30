# Dotfiles

[![CI](https://github.com/lslezak/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/lslezak/dotfiles/actions/workflows/ci.yml)

A repository to manage personal configuration files, development scripts, and a
reproducible Visual Studio Code Dev Container environment.

This can be used as a template for your own
[dotfiles](https://dotfiles.github.io/) repository.

## Features

- **Automated Installation:** A robust `install.sh` script that safely copies
  configurations to your home directory, backing up existing files when
  conflicts occur.
- **Dev Container:** Includes a complete dev container` setup for a
  reproducible, containerized development environment out of the box.
- **AI Assistant Configurations:** Pre-configured settings for AI tools like
  Claude and the Gemini.
- **Utility Scripts:** Provides useful scripts installed to `~/.local/bin/`
  directory and initialization scripts in `scripts/` directory.
- **CI & Validation:** Automated GitHub Actions for linting Dockerfiles, shell
  scripts, and validating the dev container definition.

## VSCode Integration

This repository is supposed to be used by the Dev Containers VSCode extension.

If you want to change some setting or you want to add more configurations then
fork this repository and commit your changes there.

To automatically install these dotfiles into all dev containers change the
*Settings > Extensions > DevContainer > Dotfiles: Repository*  option to the
GitHub slug name, e.g. `lslezak/dotfiles`, or `<user>/<repo>` if you forked the
repository.

See more details in the
[documentation](https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories).

## Directory Structure

### The Dotfiles

- **`dotfiles/`**: Contains the actual configuration files and directories
  mapped directly to your `$HOME` folder.
- **`scripts/`**: Executable scripts run automatically by `install.sh` during
  the setup process.
- **`install.sh`**: Automatically called by VSCode when installing the dotfiles.

### Development files

- **`.devcontainer/`**: Dockerfile and configuration for the VS Code Dev
  Container environment.
- **`.github/workflows/`**: GitHub Actions workflows for continuous integration.
- **`Makefile`**: Development commands for linting and formatting.
