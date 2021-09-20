#!/usr/bin/sh

# This script assumes you already have the working user in the sudo group.
# Most software and tools that I use will be installed automatically.

# Terminate script if any command fails
set -e

col1=2 # sections
col2=4 # package names
scount=19

ask () {
    printf '%s [Y/n] ' "$*"
    read -r ans
    if [ "$ans" = y ] || [ "$ans" = Y ] || [ -z "$ans" ]; then
        return 0
    else
        return 1
    fi
}

section () {
    printf "$(tput setaf $col1)$(tput bold)(%s/%s) %s$(tput sgr0)\n" "$snow" "$scount" "$*"
    sleep 1
}

sectionend() {
    snow=$(( snow + 1 ))
    printf "\n"
    sleep 1
}

eprint () {
    fprint "arch_postinstall.sh: %s\n" "$*" >&2;
}

pacinstall () {
    printf "installing $(tput setaf $col2)%s$(tput sgr0)... " "$*"
    if pacman -Qsq "^$@$" >/dev/null; then
        printf "found.\n"
    else
        sudo pacman -Sq --needed --noconfirm "$@" >/dev/null || printf "failed.\n"
        printf "done.\n"
    fi
}

yayinstall () {
    printf "installing $(tput setaf $col2)%s$(tput sgr0)... " "$*"
    if pacman -Qsq "^$@$" >/dev/null; then
        printf "found.\n"
    else
        yay -Sqa --needed --noconfirm "$@" >/dev/null || printf "failed.\n"
        printf "done.\n"
    fi
}

sstow () {
    printf "stowing %s... " "$*"
    stow "$@" || printf "failed.\n"
    printf "done.\n"
}

ddetach () {
    printf "detaching %s... " "$*"
    ./detach "$@" || printf "failed.\n"
    printf "done.\n"
}

##################################################################

# Variables for storing runtime configuration. This way
# the user can be asked about their preferences at the
# very start and leave the rest to be done automatically.
need_gui=
need_devtools=
need_music=
need_email=
need_sync=
need_bluetooth=
need_newsboat=
need_funcmd=
need_ytdl=
overwrite_dotfiles=
overwrite_crontabs=
snow=1

printf "\n%sINSTALLATION WIZARD%s\n" "$(tput setaf 3)" "$(tput sgr0)"
ask "(1/10) Install graphical session?"   && need_gui=1
ask "(2/10) Install development tools?"   && need_devtools=1
ask "(3/10) Install music library tools?" && need_music=1
ask "(4/10) Install email client?"        && need_email=1
ask "(5/10) Install bluetooth support?"   && need_bluetooth=1
ask "(6/10) Install sync tools?"          && need_sync=1
ask "(7/10) Install newsboat?"            && need_newsboat=1
ask "(8/10) Install youtube-dl?"          && need_ytdl=1
ask "(9/10) Overwrite local configs with dotfiles'?"   && overwrite_dotfiles=1
ask "(10/10) Overwrite local crontabs with dotfiles'?" && overwrite_crontabs=1
printf "\n"
sleep 1
if ask "Configuration Complete. Begin Installation?"; then
    printf "starting\n\n"
else
    exit 0
fi

section "Creating Directories"
cd ~
mkdir -p -- \
    Documents \
    Pictures \
    Music \
    Videos \
    Downloads \
    Software \
    .scripts \
    .local/bin \
    .sfx \
    .local/share/applications \
    .local/share/nvim/backup
[ -n "$need_gui" ] && mkdir -p -- \
    Pictures/Screenshots \
    .local/share/wallpapers
[ -n "$need_music" ] && mkdir -p -- \
    .local/share/mpd \
    .local/share/ncmpcpp
printf "done.\n"
sectionend

section "Updating Existing Packages"
sudo pacman -Syu --noconfirm
printf "done.\n"
sectionend

section "Installing Official Packages"
# pkg-config needed by several AUR packages later
# binutils needed for yay (provide "strip")
for package in \
    make cmake gcc \
    neovim \
    git \
    pass \
    stow \
    networkmanager net-tools udisks2 \
    iputils wpa_supplicant wireless_tools \
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulsemixer \
    physlock \
    ntfs-3g dosfstools which \
    arch-install-scripts \
    tmux mpv \
    curl wget reflector \
    htop \
    ntp \
    the_silver_searcher fzf \
    pkgfile \
    dash \
    python python-pip \
    pacman-contrib \
    zsh zsh-completions zsh-syntax-highlighting \
    tar gzip bzip2 xz zip unzip p7zip \
    gnupg pinentry \
    cronie \
    trash-cli \
    bc libqalculate \
    rsync \
    pkg-config binutils
do
    pacinstall "$package"
done


# "xorg" is a group of packages, so it has to be dealt with separately
[ -n "$need_gui" ] && {
    printf "installing xorg packages... "
    sudo pacman -Sq --needed --noconfirm xorg >/dev/null || printf "failed.\n"
    printf "done.\n"
}
# gcr package needed by surf later
[ -n "$need_gui" ] && for package in \
    xorg-xinit xorg-xkbcomp xorg-drivers \
    picom \
    ttf-bitstream-vera ttf-font-awesome ttf-joypixels otf-ipafont \
    xwallpaper \
    xbindkeys \
    sxiv \
    xarchiver \
    firefox \
    xf86-input-libinput \
    flameshot shotgun \
    gtk-engine-murrine materia-gtk-theme xcursor-bluecurve \
    xclip xdotool screenkey \
    libnotify dunst \
    zathura zathura-ps zathura-cb zathura-pdf-poppler \
    imagemagick graphicsmagick \
    md4c wkhtmltopdf webkit2gtk gcr
do
    pacinstall "$package"
done

[ -n "$need_devtools" ] && for package in \
    gdb valgrind \
    patch lazygit \
    tokei ctags highlight \
    shellcheck
do
    pacinstall "$package"
done

[ -n "$need_music" ] && for package in \
    mpd ncmpcpp mpc \
    beets chromaprint gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly python-gobject \
    atomicparsley
do
    pacinstall "$package"
done

[ -n "$need_email" ]     && pacinstall thunderbird
[ -n "$need_sync" ]      && pacinstall syncthing
[ -n "$need_newsboat" ]  && pacinstall newsboat

[ -n "$need_bluetooth" ] && for package in \
    bluez bluez-utils blueman
do
    pacinstall "$package"
done

[ -n "$need_funcmd" ] && for package in \
    figlet sl asciiquarium neofetch
do
    pacinstall "$package"
done
printf "done.\n"
sectionend

# Set zsh as the default shell (requires fresh login)
section "Setting ZSH as Default Shell"
chsh -s /usr/bin/zsh
printf "done.\n"
sectionend

# Install youtube-dl
section "Installing youtube-dl"
if [ -n "$need_ytdl" ]; then
    if [ ! -f "/usr/local/bin/youtube-dl" ]; then
        sudo curl -#L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
        sudo chmod a+rx /usr/local/bin/youtube-dl
        printf "done.\n"
    else
        echo youtube-dl found, skipping.
    fi
else
    echo "'youtube-dl'" disabled, skipping.
fi
sectionend

# Install beets plugins
section "Installing beets plugins"
if [ -n "$need_music" ]; then
    sudo python3 -m pip -q install beets\[fetchart,lyrics,lastgenre\] pyacoustid requests pylast pyxdg pathlib
    printf "done.\n"
else
    echo "'music'" disabled, skipping.
fi
sectionend

# Install yay
section "Installing yay"
if [ -z "$(command -v yay)" ]; then
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    wait
    cd ~
    rm -rf yay
fi
printf "done.\n"
sectionend

# Installs from AUR
section "Installing AUR Packages"
for package in \
    xxd-standalone \
    pass-update \
    pass-extension-tail \
    rar \
    lf \
    sparklines-git \
    dashbinsh
do
    yayinstall "$package"
done

[ -n "$need_gui" ] && for package in \
    numix-icon-theme-git \
    gromit-mpx-git \
    mousemode-git \
    xkeycheck-git \
    xrectsel \
    xidlehook \
    farbfeld-git \
    fsearch-git
do
    yayinstall "$package"
done

# libxft-bgra conflicts with libxft, and conflicts
# sadly cannot be resolved automatically with --noconfirm
[ -n "$need_gui" ] && {
    printf "installing $(tput setaf $col2)libxft-bgra$(tput sgr0)...\n"
    yay -Sqa --needed libxft-bgra || printf "failed.\n"
    printf "done.\n"
}

[ -n "$need_sync" ]  && yayinstall onedrive-abraunegg
[ -n "$need_music" ] && yayinstall mp3gain
printf "done.\n"
sectionend

section "Installing Paq and Deoplete for Neovim"
if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim ]; then
    printf "Paq already installed, skipping.\n"
else
    git clone https://github.com/savq/paq-nvim.git \
        "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim
fi
pip3 install -q --user pynvim
printf "done.\n"
sectionend

for i in dwm dwmblocks st dmenu surf sent; do
    section "Installing $i"
    if [ -n "$need_gui" ]; then
        cd ~/Software
        if [ -n "$(command -v "$i")" ]; then
            printf "%s already installed, skipping.\n" "$i"
        else
            git clone "https://github.com/randoragon/$i"
            cd ~/Software/$i
            sudo make install
            printf "done.\n"
        fi
    else
        echo "'gui'" disabled, skipping.
    fi
    sectionend
done

# Install id3ted
section "Installing id3ted"
if [ -n "$need_music" ]; then
    cd ~/Software
    if [ -n "$(command -v id3ted)" ]; then
        printf "id3ted already installed, skipping.\n"
    else
        git clone https://github.com/muennich/id3ted
        cd ~/Software/id3ted
        sudo make install
        printf "done.\n"
    fi
else
    echo "'music'" disabled, skipping.
fi
sectionend

# Download and apply dotfiles
section "Installing dotfiles"
[ ! -d ~/dotfiles ] && {
    cd ~
    git clone 'https://github.com/Randoragon/dotfiles'
}
rm -f -- ~/.bashrc ~/.bash_profile

if [ -n "$overwrite_dotfiles" ]; then
    cd ~/dotfiles
    [ -n "$need_music" ] && sstow beets
    ddetach cronie
    [ -n "$need_gui" ] && sstow dunst
    [ -n "$need_gui" ] && sstow dwm
    [ -n "$need_gui" ] && ddetach flameshot
    sstow git
    ddetach gpg
    [ -n "$need_gui" ] && sstow gromit-mpx
    [ -n "$need_gui" ] && sstow gtk
    sstow less
    sstow lf
    ddetach mime
    [ -n "$need_music" ] && sstow mpd
    [ -n "$need_music" ] && sstow ncmpcpp
    sstow newsboat
    sstow nvim
    [ -n "$need_gui" ] && sstow picom
    sstow python
    #sstow redshift
    sstow scripts
    sstow shell
    #ddetach speedcrunch
    [ -n "$need_gui" ] && sstow sxiv
    sstow tmux
    sstow wget
    [ -n "$need_gui" ] && ddetach xbindkeys
    [ -n "$need_gui" ] && ddetach xkb
    [ -n "$need_gui" ] && sstow xorg
    [ -n "$need_gui" ] && sstow zathura

    printf "copying sfx... "
    cp -- .other/alarm.wav         ~/.sfx || printf "failed.\n"
    cp -- .other/notification.mp3  ~/.sfx || printf "failed.\n"
    cp -- .other/notification2.mp3 ~/.sfx || printf "failed.\n"
    printf "done.\n"
else
    echo "'overwrite_dotfiles'" disabled, skipping.
fi
sectionend

# Install neatroff
section "Installing neatroff and tmac-rnd"
if [ -n "$need_gui" ]; then
    cd ~/Software
    if [ -d neatroff ]; then
        printf "neatroff already installed, skipping.\n"
    else
        git clone 'git://repo.or.cz/neatroff_make.git' neatroff
        cd ~/Software/neatroff
        make init neat
        cd ~/Software/neatroff/neatpost/
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
        ln -sft ~/Software/neatroff/tmac -- ~/dotfiles/.other/tmac.rnd
        printf "done.\n"
    fi

    cd ~/Software
    if [ -d tmac-rnd ]; then
        printf "tmac-rnd already installed, skipping.\n"
    else
        git clone 'https://github.com/Randoragon/tmac-rnd'
        cd tmac-rnd
        make
        ln -Tfs -- ~/Software/tmac-rnd/src/tmac.media ~/Software/neatroff/tmac/tmac.media
        ln -Tfs -- ~/Software/tmac-rnd/tmac.rnd   ~/Software/neatroff/tmac/tmac.rnd
        printf "done.\n"
    fi
else
    echo "'gui'" disabled, skipping.
fi
sectionend

section "Finishing Touches"

printf "linking (vi → vim) and (vim → nvim)... "
sudo ln -sfT /usr/bin/nvim /usr/bin/vim || printf "failed.\n"
sudo ln -sfT /usr/bin/vim /usr/bin/vi   || printf "failed.\n"
printf "done.\n"

printf "enabling NetworkManager... "
sudo systemctl enable NetworkManager.service || printf "failed.\n"
sudo systemctl enable wpa_supplicant.service || printf "failed.\n"
sudo usermod -aG network "$USER"             || printf "failed.\n"
sudo systemctl start wpa_supplicant.service  || printf "failed.\n"
sudo systemctl start NetworkManager.service  || printf "failed.\n"
printf "done.\n"

printf "linking (exo-open → xdg-open)... "
if [ -f /usr/bin/exo-open ] && [ ! -L /usr/bin/exo-open ]; then
    sudo ln -sfT /usr/bin/xdg-open /usr/bin/exo-open || printf "failed.\n"
fi
printf "done.\n"

printf "enabling ntpd... "
sudo systemctl enable ntpd.service || printf "failed.\n"
sudo systemctl start ntpd.service  || printf "failed.\n"
printf "done.\n"

printf "installing crontabs... "
if [ -n "$overwrite_crontabs" ]; then
    cd ~/dotfiles/.other
    [ -f crontab ]  && crontab - <./crontab
    [ -f cronroot ] && sudo sh -c 'crontab - <./cronroot'
    [ -f anacron-pacman.sh ] && sudo cp -- anacron-pacman.sh /etc/cron.weekly/
    printf "done.\n"
else
    echo "'overwrite_crontabs'" disabled, skipping.
fi

printf "enabling cron... "
sudo systemctl enable cronie.service || printf "failed.\n"
sudo systemctl start cronie.service  || printf "failed.\n"
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/anacron/spool"
printf "done.\n"

# Symlink deprecated mimelist for old applications
# Source: https://wiki.archlinux.org/index.php/XDG_MIME_Applications#mimeapps.list
printf "linking deprecated mimeapps.list file to new location... "
if [ ! -L ~/.local/share/applications/mimeapps.list ]; then
    ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list || printf "failed.\n"
fi
printf "done.\n"

printf "setting up default gpg-agent pinentry program... "
sudo ln -sTf /usr/bin/pinentry-gtk-2 /usr/bin/pinentry || printf "failed.\n"
printf "done.\n"

printf "cleaning up... "
[ -d ~/go ]     && mv -f -- ~/go     ~/.local/share
[ -d ~/.gnupg ] && mv -f -- ~/.gnupg ~/.local/share
rm -f -- ~/.bash_history
rm -f -- ~/.lesshst
rm -f -- ~/.wget-hsts
printf "done.\n"
sectionend

cd ~

printf "%sScript finished successfully.%s\n" "$(tput setaf 3)" "$(tput sgr0)"
