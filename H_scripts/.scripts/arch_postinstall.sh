#!/bin/sh

# This script assumes you already have the working user in the sudo group.
# Most software and tools that I use will be installed automatically.

# Create home folder structure
cd ~
mkdir -p Documents Pictures/Screenshots Music Videos Downloads Software \
    Projects/Dev Projects/Art Projects/Video Projects/Music Projects/Other \
    .scripts .local/bin .sfx

# Installs from the official arch repository
sudo pacman -Syu
sudo pacman -S --needed \
    make cmake gcc gdb \
    lynx \
    git \
    picom rofi \
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
    lf doublecmd thunar thunar-archive-plugin thunar-volman thunar-media-tags-plugin xarchiver \
    zip unzip \
    curl \
    firefox thunderbird \
    qalculate-gtk \
    htop xfce4-taskmanager \
    mousepad \
    fakeroot \
    npm \
    lxappearance \
    xf86-input-libinput \
    autoconf \
    bluez bluez-utils blueman \
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pavucontrol \
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
    gvim fzf \
    xdotool \
    pacman-contrib \
    libnotify dunst \
    imagemagick graphicsmagick \
    i3-wm perl-anyevent-i3 \
    figlet sl cmatrix \
    traceroute tree \
    python-mutagen \ # mid3v2
    zsh zsh-completions

# Update npm, install node-gyp and configure npm
npm_installed="$(npm list -g --depth=0 | sed "/^\/.*/d")"
sudo npm install -g npm
[ -z "$(echo "$npm_installed" | grep "node-gyp@")" ] && sudo npm install -g node-gyp
npm config set python /usr/bin/python2
unset npm_installed

# Install youtube-dl
[ -f "/usr/local/bin/youtube-dl" ] || sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# Install beets plugins
sudo python3 -m pip install beets[fetchart,lyrics,lastgenre] pyacoustid requests pylast python-mpd2 pyxdg pathlib flask jinja2

# Disable GIMP splash screen
sudo sed -i 's/^Exec=[^ ]*/& --no-splash/' /usr/share/applications/gimp.desktop

# Install yay
if [ -z "$(command -v yay)" ]; then
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    wait
    cd ~
    rm -rf yay
fi

# Installs from AUR
yay -Syu
yay -S --needed \
    polybar \
    ttf-unifont \
    termite \
    megasync megacmd-bin \
    numix-gtk-theme numix-icon-theme-git \
    megacmd-bin \
    network-manager-applet \
    trash-cli rmtrash \
    snapd \
    mimeo \
    screenkey \
    id3ted \
    etcher-bin \
    zsh-syntax-highlighting

# Python modules
sudo python3 -m pip install aubio numpy eyeD3

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

# Download dotfiles and apply some of them
[ ! -d ~/dotfiles ] \
    && cd ~ \
    && git clone https://github.com/Randoragon/dotfiles
cd dotfiles
git pull
[ -f ~/.bash_profile ] && rm ~/.bashrc ~/.bash_profile
stow H_beets
stow H_copyq
stow H_dbu
stow H_doublecmd
stow H_dunst
stow H_flameshot
stow H_i3
stow H_keepassxc
stow H_lynx
stow H_megacmd
stow H_mpd
stow H_ncmpcpp
stow H_picom
stow H_polybar
stow H_rofi
stow H_scripts
stow H_shell
stow H_termite
stow H_tmux
stow H_vim
stow H_xbindkeys
stow H_xdg-mime
stow H_xorg
stow H_youtube-dl

# Symlink common auto-openers to mimeo
[ -L /usr/bin/xdg-open ] || sudo ln -sfT /usr/bin/mimeo /usr/bin/xdg-open
[ -L /usr/bin/exo-open ] || sudo ln -sfT /usr/bin/mimeo /usr/bin/exo-open

# enable ntp (time synchronization)
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# Set termite as default i3 terminal
[ -L /usr/local/bin/x-terminal-emulator ] || sudo ln -sfT /usr/bin/termite /usr/local/bin/x-terminal-emulator

# Enable bluetooth
sudo systemctl enable bluetooth.service

# Replace sh with dash for speed
[ -L /usr/bin/sh ] || sudo ln -sfT /usr/bin/dash /usr/bin/sh
[ -L /bin/sh ]     || sudo ln -sfT /usr/bin/dash /bin/sh

# Symlink deprecated mimelist for old applications
# Source: https://wiki.archlinux.org/index.php/XDG_MIME_Applications#mimeapps.list
[ -L ~/.local/share/applications/mimeapps.list ] \
    || ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

# Finalize snap installation
sudo systemctl enable snapd.socket
[ -L /snap ] || sudo ln -s /var/lib/snapd/snap /snap

# Copy custom services to /lib/systemd/system
cd ~/dotfiles/services
chmod +x ./move.sh
./move.sh

cd ~

