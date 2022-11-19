#!/usr/bin/sh

# This script is called everytime a file is
# being opened by xdg-open using text.desktop
# application (connected to text/plain files).
#
# The idea is to be able to open different types
# of text/plain files differently. I've tried for
# hours upon hours to add my own MIME type for things
# like markdown files, but it just won't work,
# so I'm writing this simple script instead.
#
# The script will determine the best way to open
# a file based solely on its extension. You can
# pass multiple filenames as input parameters.
#
# DEPENDENCIES
# - md2html (md4c)
# - surf
# - env: TERMINAL, EDITOR, PDF_READER
# - env (optional): HTML_MD_STYLE

# Check for existence of necessary programs
command -v "$TERMINAL" || { notify-send '$TERMINAL not found' "failed to open\n$f" && exit 1; }
command -v "$EDITOR" || { notify-send '$EDITOR not found' "failed to open\n$f" && exit 1; }
command -v "$PDF_READER" || { notify-send '$PDF_READER not found' "failed to open\n$f" && exit 1; }

for f in "$@"; do

    # Skip if file doesn't exist or has no read permission
    [ ! -r "$f" ] && {
        printf 'open-plain-text.sh: cannot read file "%s"\n' "$f" >&2
        continue
    }

    # Open based on file extension
    fname="$(basename -- "$f")"
    case "${fname##*.}" in
        md|MD) # markdown
            tmp="$(mktemp -p /tmp -- open-plain-text.XXXXX.html)"
            printf "%s" "$HTML_MD_STYLE" >"$tmp"
            md2html --github -- "$f" >>"$tmp"
            surf -z 1.5 -- file://"$tmp"
            shred -u -- "$tmp"
            ;;
        adoc) # Asciidoc
            tmp="$(mktemp -p /tmp -- open-plain-text.XXXXX.html)"
            dirname="$(dirname -- "$f")"
            asciidoctor $ASCIIDOCTOR_OPTS -a imagesdir="$dirname" -a stylesdir="$dirname" -o "$tmp" -- "$f"
            surf -S -- file://"$tmp"
            shred -u -- "$tmp"
            ;;
        mom) # groff -mom
            pdfmom -ket -- "$f" | $PDF_READER -
            ;;
        rnd) # neatroff -mrnd
            ntmake "$f" -mrnd | $PDF_READER -
            ;;
        mm) # neatroff -mm
            ntmake "$f" -mm | $PDF_READER -
            ;;
        ms) # neatroff -ms
            ntmake "$f" -ms | $PDF_READER -
            ;;
        groff) # pure groff
            groff -ket -- "$f" | $PDF_READER -
            ;;
        tex|latex) # latex
            lxmake "$f" - | $PDF_READER -
            ;;
        0|1|2|3|4|5|6|7|8|9) # man page
            "$TERMINAL" -e man -l -- "$f"
            ;;
        *)
            "$TERMINAL" -e "$EDITOR" -- "$f"
            ;;
    esac
done
