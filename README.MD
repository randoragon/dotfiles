# .DotFiles

## Overview

This repository holds my Arch Linux configuration files (a lot of it is analogical to other distros).
Everything is managed by **GNU Stow**. To copy this repository's configuration into your computer, follow these steps:

```sh
cd ~
git clone https://github.com/Randoragon/dotfiles
cd dotfiles
stow [-t <target folder>] <directory name>
```

- *target_folder (1)*: for directories with the `H_` prefix, just ignore this parameter and call `stow <directory name>`
- *target_folder (2)*: for directories with the `R_` prefix, call `stow -t / <directory name>` (root folder)
- *directory name*: the name of one of config directories inside the dotfiles repository

Every directory inside this repository holds a folder structure relative to either HOME or ROOT directory.
For example, running `stow H_vim` would automatically create symlinks in the home directory that point to all the respective files inside this repository.
However, the config files that reside higher than the home directory for simplicity have been prefixed with `R_`, so that you know when to use the `-t` parameter, which specifies the relative folder for stow to create symlinks in (default is the one-higher folder).

Therefore, to copy all home configs (this is not recommended):

`stow H_*`

And to copy all root configs:

`sudo stow -t / R_*`

Root-oriented stows should be avoided, usually there's a way to store configs in the home directory.

Some files cannot be stowed, because for them to work they cannot exist in the filesystem as symlinks.
For that reason, the "other" directory exists, and it contains all of the oddballs that don't belong elsewhere.
Installing configs from the "other" directory has to be done manually and will not be covered here or anywhere
else, because the files there usually only matter to me, and it's usually intuitive how one should install them
(e.g. crontabs).
