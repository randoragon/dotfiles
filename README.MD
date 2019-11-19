# .DotFiles

## Overview

This repository holds my linux configuration files (and other files which generally I want to have on every linux installation).
Everything is managed by **GNU Stow**. To copy this repository's configuration into your computer, follow these steps:

```bash
cd ~
git clone https://github.com/Randoragon/dotfiles
cd dotfiles
stow -t <target folder> -D <directory name>
```

- *target_folder (1)*: for directories with the `H_` prefix, just ignore this parameter and call `stow -D <directory name>`
- *target_folder (2)*: for directories with the `R_` prefix, call `stow -t / -D <directory name>` (root folder)
- *directory name*: the name of one of config directories inside the dotfiles repository
- *`-D` option*: delete already existing files, if such exist. Without this parameter the existing files have priority over repo files.

Every directory inside this repository holds a folder structure relative to either HOME or ROOT directory.
For example, running `stow vim` would automatically create symlinks in the home directory that point to all the respective files inside this repository.
However, the config files that reside higher than the home directory for simplicity have been prefixed with `R_`, so that you know when to use the `-t` parameter, which specifies the relative folder for stow to create symlinks in (default is the one-higher folder).

Therefore, to copy all home configs:

`stow -D H_*`

And to copy all root configs:

`stow -t / -D R_*`

DO NOT EVER DO THIS IN ANY SHAPE OR FORM:

`stow *`

Enjoy.
