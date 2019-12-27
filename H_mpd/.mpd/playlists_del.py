#!/bin/bash

# This script does the reverse of plnew, it deletes a m3u playlist and removes its entry from the csv file.

import sys
import os
import subprocess

HOME_DIR = str(subprocess.Popen("echo $HOME", stdout=subprocess.PIPE, shell=True).stdout.read())[2:-3]
CSV_FILE = HOME_DIR + '/.config/rofi/playlists.csv'
PLAYLIST_DIR = HOME_DIR + '/Music/Playlists/'

def rprint(msg):
    return os.system('rofi -e "{}" -markup'.format(msg))

if __name__ == '__main__':
    if len(sys.argv) != 2:
        rprint('<i>E: playlists_del.py:</i> <b>Exactly one parameter required (received {})</b>'.format(len(sys.argv)-1))
        sys.exit(1)

    plname = str(sys.argv[1])
    playlist = PLAYLIST_DIR + plname + '.m3u'
    playlist_rel = playlist.replace(HOME_DIR, '~')

    os.system('rm {}'.format(playlist))

    f = open(CSV_FILE, 'r')
    lines = f.readlines()
    f.close()
    j = len(lines)
    i = 0
    while i < j:
        if lines[i].find(playlist_rel) != -1:
            lines = lines [:i] if i == j-1 else lines[:i] + lines[i+1:]
            i -= 1
            j -= 1
            f = open(CSV_FILE, 'w')
            f.writelines(lines)
            f.close()
        i += 1

    sys.exit(0)
