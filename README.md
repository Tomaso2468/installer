# Linux Setup Installer
This repository contains a series of bash files to automatically install and setup my desktop environment, development environment, and other part of my Linux setup.
This is intended to be run on any Debian based Linux distribution. Currently, aarch64 and amd64 CPU architectures are supported.

## Requirements
The following programs are required:
- `bash`
- `uname`
- `apt`

## Configuration
The configuration for this setup can be found in https://github.com/Tomaso2468/dotfiles.

## Usage
**Warning: Running any of these commands could completely alter the installed programs of your Linux install. This is designed to be used on a fresh Debian install.**
### Installing
To install the setup run in the installer directory the command:
```bash
./install.sh
```
This will install the command line and development environment.
If the desktop environment is also wanted the command:
```bash
./install.sh desktop
```
can be used.
### Updating
To update to the newest version run:
```bash
./update.sh
```
This will update all of the packages, recompile required programs, and update dotfiles.
Additionally, some desktop components require the following command to be used instead:
```bash
./update.sh desktop
```
