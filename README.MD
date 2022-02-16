# .DotFiles

## Overview

This repository holds my Arch Linux configuration files (a lot of it is analogical to other distros).
Everything is managed by **GNU Stow**. To copy this repository's configuration into your computer, follow these steps:

```sh
cd ~
git clone https://github.com/Randoragon/dotfiles
cd dotfiles
stow <directory name>
./detach <directory name>
```

Each non-hidden directory in this repo holds configuration files which can be installed using either the ``stow`` command, or the ``detach`` script.
Stow will create symlinks pointing to the ~/dotfiles directory, while detach will create normal copies.
Read the comments inside the ``detach`` script for more details and the rationale behind it.

Some files cannot be stowed for various reasons, for example crontabs are not stored as simple config files that can be symlinked.
For that reason, the ``.other`` directory exists, and it contains all the oddballs that don't belong elsewhere.
Installing configs from the ``.other`` directory has to be done manually (or see [Installation](https://github.com/Randoragon/dotfiles#installation-arch-linux)).

Any unused configuration files (e.g. from window managers that I'm not currently
using, but have configured to some extent in the past) are stored in the
``.unused`` directory.

## Installation (Arch Linux)

To make matters convenient when performing a fresh system installation, I've written a single script that handles it the way I like it.
You can find it at ``scripts/.scripts/arch_postinstall.sh`` (or click [here](https://github.com/randoragon/dotfiles/blob/master/scripts/.scripts/arch_postinstall.sh)).  
Note that this script merely installs and configures all the software that I use. It is meant to be run only once an Arch Linux [installation process](https://wiki.archlinux.org/index.php/Installation_guide) is finished.

## Disclaimer

All the files, tips, scripts, and other data contained in this repository are distributed under no warranty. They are simply resources I've written **for myself** and released to the public for two reasons:

1. Convenience - so that I have an easy way to share my scripts with others or use github links as reference
2. Information - so that other Linux users may find my solutions and replicate/improve them for their own use

You are free to copy, modify and redistribute these configs, but I'm not responsible for what you do with them
(see LICENSE).
