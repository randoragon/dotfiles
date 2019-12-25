#!/usr/bin/python3

# This script creates a new m3u playlist and adds adequate entries to the playlists.csv file
# to make other scripts work with the new playlist out of the box.

import os
import sys

CSV_FILE = '/home/pcache/.config/rofi/playlists.csv'
ADD_SCRIPT = '~/.config/rofi/playlists_add.py'
PLAYLIST_DIR = '~/Music/Music/Playlists/'

def rprint(msg):
    return os.system('rofi -e "{}" -markup'.format(msg))

def file_exists(path):
    try:
        open(path, 'r').close()
        return True
    except:
        return False

if __name__ == '__main__':
    if len(sys.argv) != 2:
        rprint('<i>E: playlists_new.py:</i> <b>Exactly one parameter required (received {})</b>'.format(len(sys.argv)-1))
        sys.exit(1)
    
    plname = str(sys.argv[1])
    playlist = PLAYLIST_DIR + plname + '.m3u'

    if not file_exists(playlist):
        os.system('touch {}'.format(playlist))
        f = open(CSV_FILE, 'a')
        f.write('{},python3 {} {}\n'.format(plname, ADD_SCRIPT, playlist))
        f.close()
        sys.exit(0)
    else:
        rprint('<i>W: playlists_new.py:</i> <b>This playlist already exists!</b>')
        sys.exit(1)
