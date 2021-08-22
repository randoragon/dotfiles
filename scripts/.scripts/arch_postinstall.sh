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
    neovim \
    firefox \
    git patch lazygit \
    picom \
    pass \
    stow \
    xorg xorg-xinit xorg-xkbcomp xorg-drivers \
    xbindkeys xwallpaper \
    ttf-bitstream-vera ttf-font-awesome ttf-joypixels otf-ipafont \
    gparted \
    mpd ncmpcpp mpc beets chromaprint gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly python-gobject \
    networkmanager udisks2 \
    iputils wpa_supplicant wireless_tools \
    sxiv mpv \
    python3 python-pip go \
    tmux \
    xarchiver \
    curl wget reflector \
    thunderbird \
    bc libqalculate \
    qrencode zbar \
    htop \
    fakeroot \
    xf86-input-libinput \
    autoconf pkgconf \
    bluez bluez-utils blueman \
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pulsemixer \
    ntp \
    ntfs-3g dosfstools which \
    arch-install-scripts \
    xclip \
    gtk-engine-murrine materia-gtk-theme xcursor-bluecurve \
    flameshot shotgun \
    the_silver_searcher fzf \
    pkgfile \
    dash \
    xdotool \
    pacman-contrib \
    libnotify dunst \
    imagemagick graphicsmagick \
    figlet sl asciiquarium \
    zsh zsh-completions zsh-syntax-highlighting \
    tar gzip bzip2 xz zip unzip p7zip \
    gnupg pinentry \
    cronie \
    tokei ctags highlight \
    neofetch screenkey \
    trash-cli \
    atomicparsley \
    zathura zathura-ps zathura-cb zathura-pdf-poppler \
    md4c wkhtmltopdf \
    shellcheck \
    newsboat \
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
    onedrive-abraunegg \
    numix-icon-theme-git \
    rar \
    bfg \
    mp3gain \
    gromit-mpx-git \
    lf \
    libxft-bgra \
    sparklines-git \
    xidlehook \
    pass-extension-tail
    farbfeld-git \
    mousemode-git \
    xkeycheck-git \
    xrectsel \
    dashbinsh

# Install NeoVim dependencies (Paq, Deoplete plugin)
git clone https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim
pip3 install --user pynvim

# Install programs from my GitHub
for i in dwm dwmblocks st dmenu surf sent; do
    ecd ~/Software
    git clone "https://github.com/randoragon/$i"
    ecd ~/Software/"$i"
    sudo make install
done

# Install id3ted
ecd ~/Software
git clone https://github.com/muennich/id3ted
ecd ~/Software/id3ted
sudo make install

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
#stow copyq
./detach cronie
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/anacron/spool"
stow dunst
stow dwm
./detach flameshot
stow git
stow gromit-mpx
stow gtk
#stow i3
#./detach keepassxc
#stow krita
stow less
stow lf
stow lynx
./detach mime
stow mpd
stow ncmpcpp
stow newsboat
stow nvim
stow picom
#stow polybar
stow python
#stow redshift
stow scripts
stow sfx
stow shell
#./detach speedcrunch
stow sxiv
stow tmux
stow wget
./detach xbindkeys
./detach xkb
stow xorg
stow zathura
ln -s -- "$PWD/.other/tmac.rnd" ~/Software/neatroff/tmac

# Install neatroff
ecd ~/Software
git clone 'git://repo.or.cz/neatroff_make.git' neatroff
ecd ~/Software/neatroff
make init neat
ecd ~/Software/neatroff/neatpost/
git apply ~/dotfiles/.other/neatroff-invisible-links.diff
make
ln -Tfs -- ~/Software/neatroff/neatroff/roff   ~/.local/bin/ntroff
ln -Tfs -- ~/Software/neatroff/troff/pic/pic   ~/.local/bin/ntpic
ln -Tfs -- ~/Software/neatroff/troff/tbl/tbl   ~/.local/bin/nttbl
ln -Tfs -- ~/Software/neatroff/neateqn/eqn     ~/.local/bin/nteqn
ln -Tfs -- ~/Software/neatroff/neatmkfn/mkfn   ~/.local/bin/ntmkfn
ln -Tfs -- ~/Software/neatroff/neatpost/post   ~/.local/bin/ntpost
ln -Tfs -- ~/Software/neatroff/neatpost/pdf    ~/.local/bin/ntpdf
ln -Tfs -- ~/Software/neatroff/neatrefer/refer ~/.local/bin/ntrefer
ln -Tfs -- ~/Software/neatroff/shape/shape     ~/.local/bin/ntshape
ln -Tfs -- ~/Software/neatroff/soin/soin       ~/.local/bin/ntsoin
cp -- ~/dotfiles/.other/neatroff-devutf/* ~/Software/neatroff/devutf/

# Install neatroff rnd macros
ecd ~/Software
git clone 'https://github.com/Randoragon/tmac-rnd'
make
ln -Tfs -- ~/Software/tmac-rnd/src/tmac.media ~/Software/neatroff/tmac/tmac.media
ln -Tfs -- ~/Software/tmac-rnd/tmac.rnd   ~/Software/neatroff/tmac/tmac.rnd

# Replace vi with vim and vim with nvim
sudo ln -sfT /usr/bin/nvim /usr/bin/vim
sudo ln -sfT /usr/bin/vim /usr/bin/vi

# Symlink common auto-openers to xdg-open
[ -f /usr/bin/exo-open ] && [ ! -L /usr/bin/exo-open ] && sudo ln -sfT /usr/bin/xdg-open /usr/bin/exo-open

# Enable ntp (time synchronization)
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# Enable cronie and install (ana)crontabs
sudo systemctl enable cronie.service
sudo systemctl start cronie.service
ecd ~/dotfiles/.other
[ -f crontab ] && crontab - <./crontab
[ -f cronroot ] && sudo sh -c 'crontab - <./cronroot'
[ -f anacron-pacman.sh ] && sudo cp -- anacron-pacman.sh /etc/cron.weekly/

# Symlink deprecated mimelist for old applications
# Source: https://wiki.archlinux.org/index.php/XDG_MIME_Applications#mimeapps.list
[ -L ~/.local/share/applications/mimeapps.list ] || ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

# Configure gpg-agent default authorization program
sudo ln -sTf /usr/bin/pinentry-gtk-2 /usr/bin/pinentry

ecd ~
