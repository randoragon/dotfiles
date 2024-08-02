#!/bin/sh

# This script assumes you already have the working user in the sudo group.
# Most software and tools that I use will be installed automatically.

# Terminate script if any command fails
set -e

col1=2 # sections
col2=4 # package names
scount=17

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
    printf "arch_postinstall.sh: %s\n" "$*" >&2;
}

pacinstall () {
    printf "installing $(tput setaf $col2)%s$(tput sgr0)... " "$*"
    if pacman -Qsq "^$1$" >/dev/null; then
        printf "found.\n"
    else
        sudo pacman -Sq --needed --noconfirm "$1" >/dev/null || printf "failed.\n"
        printf "done.\n"
    fi
}

yayinstall () {
    printf "installing $(tput setaf $col2)%s$(tput sgr0)... " "$*"
    if pacman -Qsq "^$1$" >/dev/null; then
        printf "found.\n"
    else
        yay -Sqa --needed --noconfirm "$1" >/dev/null || printf "failed.\n"
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
need_rss=
need_funcmd=
need_ytdl=
need_obs=
need_accounting=
overwrite_dotfiles=
overwrite_crontabs=
snow=1

printf "\n%sINSTALLATION WIZARD%s\n" "$(tput setaf 3)" "$(tput sgr0)"
ask "(1/14) Install graphical session?"      && need_gui=1
ask "(2/14) Install development tools?"      && need_devtools=1
ask "(3/14) Install music library tools?"    && need_music=1
ask "(4/14) Install music production tools?" && need_makemusic=1
ask "(5/14) Install email client?"           && need_email=1
ask "(6/14) Install bluetooth support?"      && need_bluetooth=1
ask "(7/14) Install sync tools?"             && need_sync=1
ask "(8/14) Install RSS reader?"             && need_rss=1
ask "(9/14) Install youtube-dl?"             && need_ytdl=1
ask "(10/14) Install OBS?"                   && need_obs=1
ask "(11/14) Install accounting tools?"      && need_accounting=1
ask "(12/14) Install fun commands?"          && need_funcmd=1
ask "(13/14) Overwrite local dotfiles?"      && overwrite_dotfiles=1
ask "(14/14) Overwrite local crontabs with dotfiles'?" && overwrite_crontabs=1
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
# ripgrep needed for some scripts and for general use
for package in \
    make cmake gcc \
    neovim python-pynvim tree-sitter tree-sitter-cli \
    git \
    pass \
    stow \
    networkmanager net-tools udisks2 \
    iputils wpa_supplicant wireless_tools \
    pipewire pipewire-pulse pipewire-jack pipewire-alsa \
    wireplumber qpwgraph carla pulsemixer \
    physlock \
    ntfs-3g dosfstools which \
    arch-install-scripts \
    lf \
    tmux mpv \
    curl wget reflector \
    htop \
    ntp \
    ripgrep fzf \
    pkgfile \
    dash jq \
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


[ -n "$need_gui" ] && for package in \
    river xdg-desktop-portal xdg-desktop-portal-wlr \
    swayidle waylock swww \
    bemenu bemenu-ncurses bemenu-wayland \
    foot \
    grim slurp swappy \
    brightnessctl \
    mako \
    ttf-jetbrains-mono ttf-dejavu ttf-opensans ttf-font-awesome ttf-joypixels otf-ipafont \
    ttf-liberation ttf-carlito libertinus-font \
    sxiv oculante \
    xarchiver \
    firefox \
    gtk-engine-murrine materia-gtk-theme xcursor-bluecurve \
    wl-clipboard wlr-randr \
    zathura zathura-ps zathura-cb zathura-pdf-poppler \
    imagemagick graphicsmagick \
    md4c \
    asciidoctor rubygems mathjax2 graphviz gnuplot \
    texlive-basic texlive-xetex \
    texlive-latexrecommended texlive-fontsrecommended \
    texlive-latexextra texlive-plaingeneric \
    texlive-langcjk texlive-binextra \
    texlive-bibtexextra biber \
    typst typst-lsp
do
    pacinstall "$package"
done

[ -n "$need_gui" ] && {
    # Install asciidoctor gems
    gem install asciidoctor-diagram
    gem install asciidoctor-pdf

    # Force asciidoctor to use local MathJax instance
    html5rb="$(pacman -Ql asciidoctor | grep '/html5\.rb')"
    if [ -f "${html5rb#* }" ]; then
        sudo sed -i 's|#{cdn_base_url}/mathjax/#{MATHJAX_VERSION}|/usr/share/mathjax2|' "${html5rb#* }"
    else
        eprint 'asciidoctor html.rb file not found, failed to configure MathJax'
    fi
}

[ -n "$need_devtools" ] && for package in \
    bear clang \
    lua-language-server texlab gopls \
    pyright ruff \
    vscode-html-languageserver vscode-css-languageserver typescript-language-server \
    gdb valgrind \
    patch lazygit \
    tokei highlight \
    bash-language-server shellcheck \
    lua lua-filesystem lua-penlight lua-lpeg \
    rust rust-analyzer
do
    pacinstall "$package"
done

# lua for music scripts,
# rust and openssl-1.1 for mpd-discord-rpc
[ -n "$need_music" ] && for package in \
    mpd ncmpcpp mpc \
    chromaprint gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly python-gobject \
    atomicparsley \
    mp3info \
    lua lua-filesystem \
    rust openssl-1.1 \
    python-musicbrainzngs
do
    pacinstall "$package"
done

[ -n "$need_makemusic" ] && for package in \
    alsa-utils \
    helm-synth \
    geonkick \
    x42-plugins \
    distrho-ports-lv2 \
    sfizz \
    vmpk \
    ardour \
    hydrogen \
    zynaddsubfx
do
    pacinstall "$package"
done

[ -n "$need_email" ]     && pacinstall thunderbird
[ -n "$need_sync" ]      && pacinstall syncthing
[ -n "$need_bluetooth" ] && pacinstall bluez bluez-utils
[ -n "$need_ytdl" ]      && pacinstall youtube-dl yt-dlp
[ -n "$need_obs" ]       && pacinstall obs-studio

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
    pass-extension-tail \
    rar \
    sparklines-git \
    dashbinsh
do
    yayinstall "$package"
done

[ -n "$need_gui" ] && for package in \
    rivercarro yambar \
    numix-icon-theme-git \
    farbfeld-git \
    ttf-unifont \
    mscgen
do
    yayinstall "$package"
done

[ -n "$need_devtools" ] && for package in \
    lua-cjson \
    zls
do
    yayinstall "$package"
done

[ -n "$need_rss" ]   && yayinstall newsraft
[ -n "$need_sync" ]  && yayinstall onedrive-abraunegg

[ -n "$need_music" ] && for package in \
    mp3gain rsgain-git \
    taptempo
do
    yayinstall "$package"
done

[ -n "$need_obs" ] && for package in \
    obs-spectralizer \
    obs-plugin-input-overlay
do
    yayinstall "$package"
done
printf "done.\n"
sectionend

# Install beets plugins and mpd-discord-rpc
section "Installing beets plugins and mpd-discord-rpc"
if [ -n "$need_music" ]; then
    for package in \
        python-pyacoustid \
        python-requests \
        python-pylast \
        python-pyxdg
    do
        pacinstall "$package"
    done
    yayinstall beets-git
    cargo install mpd-discord-rpc
    printf "done.\n"
else
    echo "'music'" disabled, skipping.
fi
sectionend

section "Installing singular LaTeX CRANs"
if [ -n "$need_gui" ]; then
    sudo tlmgr install graphviz
    sudo texhash
fi
sectionend

section "Installing Paq for Neovim"
if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim ]; then
    printf "Paq already installed, skipping.\n"
else
    git clone https://github.com/savq/paq-nvim.git \
        "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
fi
printf "done.\n"
sectionend

for i in sent; do
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

section "Installing ledger"
if [ -n "$need_accounting" ]; then
    if [ -n "$(command -v ledger)" ]; then
        echo "ledger already installed, skipping."
    else
        # Compile ledger with gpg support (the official package does not include
        # this support, unfortunately)

        # Install dependencies (https://github.com/ledger/ledger?tab=readme-ov-file#dependencies)
        for package in \
            cmake \
            boost \
            gmp \
            mpfr \
            utf8cpp \
            gpgme
        do
            pacinstall "$package"
        done

        cd ~/Software
        git clone git@github.com:ledger/ledger.git

        cd ledger
        sed -i '/^option(USE_GPGME/s/OFF)$/ON)/' CMakeLists.txt
        ./acprep --no-python dependencies
        ./acprep --no-python update
        sudo make install

        printf "done.\n"
    fi
else
    echo "'need_accounting' disabled, skipping."
fi
sectionend

# Download and apply dotfiles
section "Installing dotfiles"
[ ! -d ~/dotfiles ] && {
    cd ~
    git clone 'https://github.com/randoragon/dotfiles'
}
rm -f -- ~/.bashrc ~/.bash_profile

if [ -n "$overwrite_dotfiles" ]; then
    cd ~/dotfiles
    [ -n "$need_music" ] && sstow beets
    ddetach cronie
    sstow git
    ddetach gpg
    [ -n "$need_gui" ] && sstow gtk
    [ -n "$need_accounting" ] && sstow ledger
    sstow less
    sstow lf
    sstow lua
    [ -n "$need_gui" ] && sstow mako
    ddetach mime
    [ -n "$need_music" ] && sstow mpd
    [ -n "$need_music" ] && sstow ncmpcpp
    sstow newsraft
    sstow nvim
    sstow pipewire
    sstow python
    sstow R
    [ -n "$need_gui" ] && sstow river
    sstow scripts
    sstow shell
    [ -n "$need_gui" ] && sstow swappy
    [ -n "$need_gui" ] && sstow sxiv
    sstow tmux
    sstow wget
    [ -n "$need_gui" ] && sstow xdg-desktop-portal
    [ -n "$need_gui" ] && sstow yambar
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

# Install rust crates
for crate in music-tools rsid3; do
    section "Installing $crate"
    if [ -n "$need_music" ]; then
        cd ~/Software
        if [ -d "$crate" ]; then
            echo "$crate already installed, skipping."
        else
            git clone "https://github.com/randoragon/$crate"
            cd ~/Software/"$crate"
            cargo install --path .
            printf "done.\n"
        fi
    else
        echo "'music'" disabled, skipping.
    fi
    sectionend
done

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
