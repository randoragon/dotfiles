# .DotFiles

## Overview

This repository holds my Arch Linux configuration files (most of it applies to other distros).
Everything is managed by **GNU Stow**. To copy this repository's configuration into your computer, follow these steps:

```bash
cd ~
git clone https://github.com/Randoragon/dotfiles
cd dotfiles
stow -t <target folder> -R <directory name>
```

- *target_folder (1)*: for directories with the `H_` prefix, just ignore this parameter and call `stow -R <directory name>`
- *target_folder (2)*: for directories with the `R_` prefix, call `stow -t / -R <directory name>` (root folder)
- *directory name*: the name of one of config directories inside the dotfiles repository
- *`-R` option*: delete configs, then create them again (pretty much just updates)

Every directory inside this repository holds a folder structure relative to either HOME or ROOT directory.
For example, running `stow vim` would automatically create symlinks in the home directory that point to all the respective files inside this repository.
However, the config files that reside higher than the home directory for simplicity have been prefixed with `R_`, so that you know when to use the `-t` parameter, which specifies the relative folder for stow to create symlinks in (default is the one-higher folder).

Therefore, to copy all home configs:

`stow -R H_*`

And to copy all root configs:

`sudo stow -t / -R R_*`

DO NOT EVER DO THIS IN ANY SHAPE OR FORM:

`stow *`

...or else you will have to manually delete all R_ folders' contents from your home directory.

Enjoy.
