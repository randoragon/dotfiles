#!/usr/bin/sh

# This script assumes you already have the working user in the sudo group.
# Most software and tools that I use will be installed automatically.

eprint () { fprint "arch_postinstall.sh: %s\n" "$*" >&2; }
ecd () { cd "$1" || { eprint "failed to cd" && exit 1; } }

# Create basic folder structures
ecd ~
mkdir -p Documents Pictures/Screenshots Music Videos Downloads Software \
    .scripts .local/bin .sfx .local/share/wallpapers .local/share/applications .local/share/nvim/backup .local/share/mpd .local/share/ncmpcpp

# Installs from the official arch repository
sudo pacman -Syu
sudo pacman -S --needed \
    make cmake gcc gdb \
    firefox lynx \
    git patch \
    picom \
    pass \
    stow \
    xorg xorg-xinit xorg-xkbcomp xterm xorg-drivers numlockx \
    xbindkeys xwallpaper \
    ttf-dejavu ttf-hack ttf-opensans ttf-droid ttf-ubuntu-font-family powerline-fonts ttf-font-awesome otf-font-awesome \
    grub-customizer \
    gparted \
    mpd ncmpcpp mpc beets chromaprint gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly python-gobject \
    networkmanager \
    iputils wpa_supplicant wireless_tools gnome-keyring \
    sxiv mpv \
    python3 python-pip python-mutagen go \
    tmux \
    xarchiver \
    curl wget reflector \
    thunderbird \
    bc libqalculate speedcrunch \
    qrencode zbar \
    htop \
    fakeroot \
    adapta-gtk-theme \
    xf86-input-libinput \
    autoconf pkgconf \
    bluez bluez-utils blueman \
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pulsemixer pavucontrol \
    ntp \
    ntfs-3g dosfstools which \
    arch-install-scripts \
    xclip \
    gtk-engines gtk-engine-murrine \
    flameshot gimp \
    the_silver_searcher \
    pkgfile \
    dash \
    neovim fzf \
    wmctrl xdotool \
    pacman-contrib \
    libnotify dunst \
    imagemagick graphicsmagick \
    figlet sl asciiquarium \
    traceroute tree \
    zsh zsh-completions zsh-syntax-highlighting \
    tar gzip bzip2 xz zip unzip p7zip \
    gnupg pinentry \
    cronie \
    cpulimit \
    tokei ctags highlight \
    neofetch screenkey \
    trash-cli \
    atomicparsley \
    zathura zathura-cb zathura-pdf-poppler \
    marked wkhtmltopdf \
    shellcheck \
    newsboat weechat \
    physlock \
    rsync syncthing \
    webkit2gtk

# Replace sh with dash for speed
[ -L /usr/bin/sh ] || sudo ln -sfT /usr/bin/dash /usr/bin/sh
[ -L /bin/sh ]     || sudo ln -sfT /usr/bin/dash /bin/sh

# Set zsh as the default shell (requires fresh login)
chsh -s /usr/bin/zsh

# Install youtube-dl
[ -f "/usr/local/bin/youtube-dl" ] || sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# Install beets plugins
sudo python3 -m pip install beets\[fetchart,lyrics,lastgenre\] pyacoustid requests pylast pyxdg pathlib

# Install NeoVim dependencies (Deoplete plugin)
pip3 install --user pynvim

# Install yay
if [ -z "$(command -v yay)" ]; then
    ecd ~
    git clone https://aur.archlinux.org/yay.git
    ecd yay
    makepkg -si
    wait
    ecd ~
    rm -rf yay
fi

# Installs from AUR
yay -Syua
yay -Sa --needed \
    xxd-standalone \
    pass-update \
    ttf-unifont ttf-twemoji-color \
    onedrive-abraunegg \
    numix-icon-theme-git \
    id3ted \
    rar \
    xrectsel \
    bfg \
    mp3gain \
    gromit-mpx-git \
    nerd-fonts-dejavu-complete \
    lf \
    libxft-bgra \
    sparklines-git \
    xidlehook \
    xxd-standalone \
    mousemode-git

# Install dwm, dwmblocks, st, randoutils and surf
if [ -z "$(command -v dwm)" ]; then
    ecd ~/Software
    git clone https://github.com/Randoragon/dwm
    ecd ~/Software/dwm
    sudo make clean install
else
    echo "dwm detected, skipping."
fi
if [ -z "$(command -v dwmblocks)" ]; then
    ecd ~/Software
    git clone https://github.com/Randoragon/dwmblocks
    ecd ~/Software/dwmblocks
    sudo make clean install
else
    echo "dwmblocks detected, skipping."
fi
if [ -z "$(command -v st)" ]; then
    ecd ~/Software
    git clone https://github.com/randoragon/st
    ecd ~/Software/st
    sudo make clean install
else
    echo "st detected, skipping."
fi
if [ ! -d ~/Software/randoutils ]; then
    ecd ~/Software
    git clone https://github.com/Randoragon/randoutils
else
    echo "randoutils detected, skipping."
fi
if [ -z "$(command -v surf)" ]; then
    ecd ~/Software
    git clone https://github.com/randoragon/surf
    ecd ~/Software/surf
    sudo make clean install
else
    echo "surf detected, skipping."
fi
if [ -z "$(command -v dmenu)" ]; then
    ecd ~/Software
    git clone https://github.com/randoragon/dmenu
    ecd ~/Software/dmenu
    sudo make clean install
else
    echo "dmenu detected, skipping."
fi

# Install pass-extension-tail
if [ ! -d ~/Software/pass-extension-tail ]; then
    ecd ~/Software
    git clone 'https://github.com/palortoff/pass-extension-tail'
    ecd  ~/Software/pass-extension-tail
    sudo make install
else
    echo "pass-extension-tail detected, skipping."
fi

# Set up network manager
# Source: https://unix.stackexchange.com/a/292196
sudo systemctl disable dhcpcd.service
sudo systemctl disable dhcpcd@.service
sudo systemctl stop dhcpcd.service
sudo systemctl stop dhcpcd@.service
sudo systemctl enable NetworkManager.service
sudo systemctl enable wpa_supplicant.service
sudo gpasswd -a "$USER" network
sudo systemctl start wpa_supplicant.service
sudo systemctl start NetworkManager.service

# Download and apply dotfiles
[ ! -d ~/dotfiles ] && {
    ecd ~
    git clone 'https://github.com/Randoragon/dotfiles'
}
ecd ~/dotfiles
rm -- ~/.bashrc ~/.bash_profile

stow beets
stow dunst
./detach flameshot
stow git
#stow glava
stow gromit-mpx
stow gtk
stow dwm
./detach keepassxc
#stow krita
stow lf
#stow lmms
stow lynx
./detach mime
stow mpd
stow ncmpcpp
stow newsboat
stow nvim
stow picom
stow python
#stow redshift
stow scripts
stow sfx
stow shell
./detach speedcrunch
stow sxiv
stow tmux
stow wget
./detach xbindkeys
./detach xkb
stow xorg
stow zathura

# Replace vi with vim and vim with nvim
sudo ln -sfT /usr/bin/nvim /usr/bin/vim
sudo ln -sfT /usr/bin/vim /usr/bin/vi

# Symlink common auto-openers to xdg-open
[ -f /usr/bin/exo-open ] && [ ! -L /usr/bin/exo-open ] && sudo ln -sfT /usr/bin/xdg-open /usr/bin/exo-open

# Enable ntp (time synchronization)
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# Enable cronie and install crontabs
sudo systemctl enable cronie.service
sudo systemctl start cronie.service
ecd ~/dotfiles/.other
[ -f crontab ] && cat crontab | crontab - <crontab
[ -f cronroot ] && sudo sh -c 'cat cronroot | crontab -'

# Enable bluetooth
sudo systemctl enable bluetooth.service

# Symlink deprecated mimelist for old applications
# Source: https://wiki.archlinux.org/index.php/XDG_MIME_Applications#mimeapps.list
[ -L ~/.local/share/applications/mimeapps.list ] || ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

# Configure gpg-agent default authorization program
sudo ln -sTf /usr/bin/pinentry-gtk-2 /usr/bin/pinentry

ecd ~

