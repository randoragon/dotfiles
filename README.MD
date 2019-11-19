# .DotFiles

This repository holds my linux configuration files (and other files which generally I want to have on every linux installation).
Everything is managed by **GNU Stow**. To copy this repository's configuration into your computer, follow these steps:

```bash
cd ~
git clone https://github.com/Randoragon/dotfiles
cd dotfiles
stow <directory name>
```

Every directory inside this repository holds a folder structure relative to the home directory.  
For example, running `stow vim` would automatically create symlinks in the home directory that point to all the respective files inside this repository.
Therefore, it is extremely easy to update all the configs and federate them from one place.

You're welcome.
