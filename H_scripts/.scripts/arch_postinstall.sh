#!/usr/bin/sh

# This script assumes you already have the working user in the sudo group.
# Most software and tools that I use will be installed automatically.

eprint () { fprint "arch_postinstall.sh: %s\n" "$*" >&2; }
# Create home folder structure
cd ~ || { eprint "failed  to cd" && exit 1; }
mkdir -p Documents Pictures/Screenshots Music Videos Downloads Software \
    Projects/Dev Projects/Art Projects/Video Projects/Music Projects/Other \
    .scripts .local/bin .sfx .local/share/wallpapers

# Installs from the official arch repository
sudo pacman -Syu
sudo pacman -S --needed \
    make cmake gcc gdb \
    lynx \
    git \
    picom \
    keepassxc \
    stow \
    xorg xorg-xinit xterm xbindkeys xorg-drivers numlockx xwallpaper \
    ttf-dejavu ttf-hack ttf-opensans ttf-droid ttf-ubuntu-font-family powerline-fonts ttf-font-awesome otf-font-awesome \
    iputils \
    grub-customizer \
    gparted \
    mpd ncmpcpp mpc beets chromaprint gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly python2-gobject \
    networkmanager \
    wpa_supplicant wireless_tools gnome-keyring \
    patch \
    sxiv mpv \
    python python3 python-pip go \
    tmux \
    doublecmd xarchiver \
    zip unzip \
    curl \
    firefox thunderbird \
    libqalculate speedcrunch \
    htop xfce4-taskmanager \
    mousepad \
    fakeroot \
    npm \
    lxappearance \
    xf86-input-libinput \
    autoconf \
    bluez bluez-utils blueman \
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pulsemixer \
    ntp \
    ntfs-3g dosfstools wget which \
    arch-install-scripts \
    copyq \
    gtk-engines gtk-engine-murrine \
    base-devel \
    flameshot gimp \
    the_silver_searcher \
    pkgfile \
    dash \
    neovim fzf \
    xdotool \
    pacman-contrib \
    libnotify dunst \
    imagemagick graphicsmagick \
    i3-wm perl-anyevent-i3 \
    figlet sl asciiquarium \
    traceroute tree \
    zsh zsh-completions \
    tar gzip bzip2 xz zip unzip p7zip \
    gnupg pinentry \
    cronie \
    cpulimit \
    tokei \
    neofetch \
    trash-cli \
    atomicparsley \
    zathura zathura-cb zathura-pdf-poppler \
    marked wkhtmltopdf \
    shellcheck

# Replace sh with dash for speed
[ -L /usr/bin/sh ] || sudo ln -sfT /usr/bin/dash /usr/bin/sh
[ -L /bin/sh ]     || sudo ln -sfT /usr/bin/dash /bin/sh

# Set zsh as the default shell (requires fresh login)
chsh -s /usr/bin/zsh

# Update npm, install node-gyp and configure npm
npm_installed="$(npm list -g --depth=0 | sed "/^\/.*/d")"
sudo npm install -g npm
echo "$npm_installed" | grep -q "node-gyp@" || sudo npm install -g node-gyp
npm config set python /usr/bin/python2
unset npm_installed

# Install youtube-dl
[ -f "/usr/local/bin/youtube-dl" ] || sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# Install beets plugins
sudo python3 -m pip install beets\[fetchart,lyrics,lastgenre\] pyacoustid requests pylast python-mpd2 pyxdg pathlib flask jinja2

# Disable GIMP splash screen
sudo sed -i 's/^Exec=[^ ]*/& --no-splash/' /usr/share/applications/gimp.desktop

# Install yay
if [ -z "$(command -v yay)" ]; then
    cd ~ || { eprint "failed to cd" && exit 1; }
    git clone https://aur.archlinux.org/yay.git
    cd yay || { eprint "failed to cd" && exit 1; }
    makepkg -si
    wait
    cd ~ || { eprint "failed to cd" && exit 1; }
    rm -rf yay
fi

# Installs from AUR
yay -Syua
yay -Sa --needed \
    polybar \
    ttf-unifont \
    megacmd-bin \
    numix-gtk-theme numix-icon-theme-git \
    network-manager-applet \
    snapd \
    screenkey \
    id3ted \
    zsh-syntax-highlighting \
    rar \
    xrectsel \
    dmenu-git \
    bfg \
    mp3gain \
    gromit-mpx-git \
    nerd-fonts-complete \
    lf

# Python modules
sudo python3 -m pip install aubio numpy eyeD3 pyxdg pathlib

# Install Spark
[ -f /usr/local/bin/spark ] \
    || sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/bin/spark && chmod +x /usr/local/bin/spark"

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
    cd ~ || { eprintf "failed to cd" && exit 1; }
    git clone 'https://github.com/Randoragon/dotfiles'
}
cd ~/dotfiles || { eprint "failed to cd" && exit 1; }
git pull
rm -- ~/.bashrc ~/.bash_profile
stow H_beets
stow H_copyq
stow H_doublecmd
stow H_dunst
stow H_flameshot
stow H_git
stow H_gromit-mpx
stow H_i3
stow H_keepassxc
stow H_lf
stow H_lynx
stow H_mime
stow H_mpd
stow H_ncmpcpp
stow H_nvim
stow H_picom
stow H_polybar
stow H_scripts
stow H_sfx
stow H_shell
stow H_speedcrunch
stow H_sxiv
stow H_tmux
stow H_xbindkeys
stow H_xorg
stow H_zathura
sudo stow -t / R_scripts

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
cd ~/dotfiles || { eprint "failed to cd" && exit 1; }
[ -f crontab ] && cat crontab | crontab - <crontab
[ -f cronroot ] && sudo sh -c 'cat cronroot | crontab -'

# Enable bluetooth
sudo systemctl enable bluetooth.service

# Symlink deprecated mimelist for old applications
# Source: https://wiki.archlinux.org/index.php/XDG_MIME_Applications#mimeapps.list
[ -L ~/.local/share/applications/mimeapps.list ] || ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

# Finalize snap installation
sudo systemctl enable snapd.socket
[ -L /snap ] || sudo ln -s /var/lib/snapd/snap /snap

# Configure gpg-agent default authorization program
sudo ln -sTf /usr/bin/pinentry-tty /usr/bin/pinentry

# Install my fork of suckless terminal
if [ -z "$(command -v st)" ]; then
    cd ~/Software || { eprint "failed to cd" && exit 1; }
    git clone https://github.com/randoragon/st
    cd st || { eprint "failed to cd" && exit 1; }
    sudo make install
    sudo ln -sTf /usr/local/bin/st /usr/local/bin/x-terminal-emulator
    find . -maxdepth 1 -name "st-script-*" -print0 | xargs -0 -I % sudo ln -sTf -- "$(realpath -- "%")" "/usr/local/bin/$(basename -- "%")"
else
    echo "Suckless terminal detected, skipping."
fi

cd ~ || { eprint "failed to cd" && exit 1; }

