# This file is the console-only equivalent of ".xprofile",
# meaning it is sourced every time a user LOGS INTO a shell
# environment (which happens before starting an X session).
#
# Running shell profile files usually is done by the LOGIN shell,
# and different login shells have different profile files
# (bash: .bash_profile, zsh: .zprofile, etc.)
# Since it's annoying to have to move those specific profile files
# around, instead I have a single, consistent ".profile" file,
# and whenever I switch login shells I just symlink their respective
# profile files to this one (e.g. 'ln -s ~/.profile ~/.zprofile').

# Add custom PATH entries
# (function copied from /etc/profile)
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
appendpath "$HOME/.local/bin"
unset appendpath

# Locale settings
setxkbmap -layout pl
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Default applications
export EDITOR=nvim
export TERMINAL=st
export BROWSER=firefox
export PAGER=less

# Default directories
export XDG_DATA_DIRS=/usr/local/share:/usr/share:/var/lib/snapd/desktop:$HOME/.local/share/
export XDG_DATA_HOME="$HOME/.local/share"
export TRASH="$HOME/.local/share/Trash/files"
export GOPATH="$HOME/.local/share/go"

# Start ssh-agent if not already running
ps -e | grep "$SSH_AGENT_PID"  | grep "ssh-agent$" || eval "$(ssh-agent -s)"

# Other configuration
export MPD_HOST="$HOME/.local/share/mpd/socket"
export MPD_PORT=6601
export i3_LAYOUTS="$HOME/.config/i3/layouts"
export LYNX_CFG="$HOME/.config/lynx/config"
export GNUPGHOME="$HOME/.local/share/gnupg"
export NNN_OPENER=xdg-open
export NNN_BMS='h:~;d:~/Documents'
export NNN_COLORS='6532'
export NNN_TRASH=1

# lf icons
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.part=💔:\
*.torrent=🔽:\
"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
