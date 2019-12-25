#!/bin/bash

# This script does the reverse of plnew, it deletes a m3u playlist and removes its entry from the csv file.

CSV_FILE = '~/.config/rofi/playlists.csv'
PLAYLIST_DIR = '~/Music/Music/Playlists/'

import sys
import os

if __name__ == '__main__':
    if len(sys.argv) != 2:
        rprint('<i>E: playlists_del.py:</i> <b>Exactly one parameter required (received {})</b>'.format(len(sys.argv)-1))
        sys.exit(1)

    plname = str(sys.argv[1])
    playlist = PLAYLIST_DIR + plname + '.m3u'

    os.system('rm {}'.format(playlist))

    f = open(CSV_FILE, 'r')
    lines = f.readlines()
    for i in range(len(lines)):
        if lines[i].find(playlist) != -1:
            f.close()
            f = open(CSV_FILE, 'w')

