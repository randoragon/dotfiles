#!/usr/bin/python3

# This script creates a new m3u playlist and adds adequate entries to the playlists.csv file
# to make other scripts work with the new playlist out of the box.

import os
import sys
import subprocess

HOME_DIR = str(subprocess.Popen("echo $HOME", stdout=subprocess.PIPE, shell=True).stdout.read())[2:-3]
CSV_FILE = HOME_DIR + '/.config/rofi/playlists.csv'
ADD_SCRIPT = HOME_DIR + '/.config/rofi/playlists_add.py'
PLAYLIST_DIR = HOME_DIR + '/Music/Playlists/'

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
    playlist_rel = playlist.replace(HOME_DIR, '~')

    flags = file_exists(playlist), (len(tuple(filter(lambda x: x.find(playlist_rel) != -1, open(CSV_FILE, 'r').readlines()))) != 0)

    if not flags[0]:
        os.system('touch {}'.format(playlist))
    if not flags[1]:
        f = open(CSV_FILE, 'a')
        f.write('{},python3 {} {}\n'.format(plname, ADD_SCRIPT.replace(HOME_DIR, '~'), playlist_rel))
        f.close()
    elif flags[0]:
        rprint('<i>W: playlists_new.py:</i> <b>This playlist already exists!</b>')
        sys.exit(1)
    sys.exit(0)
