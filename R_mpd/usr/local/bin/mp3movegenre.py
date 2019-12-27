#!/usr/bin/env python3

import eyed3
import sys
from os import listdir
from shutil import move
from re import search, match
from io import StringIO

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Parameters: <genre> [dir_to_move_to]')
        sys.exit(1)

    orig_out = sys.stdout
    sys.stdout = StringIO()

    GENRE = sys.argv[1]
    
    def mp3filter(x):
        if search(r'[^\.]\.mp3$', x) != None:
            f = eyed3.load(x)
            return search(r'(.*){}\1'.format(GENRE.lower()), str(f.tag.genre).lower()) != None
        return False

    files = list(filter(mp3filter, listdir()))

    sys.stdout = orig_out
    print('\nFOUND {} FILES:'.format(len(files)))
    for i in files:
        print('  ' + i)

    if len(sys.argv) > 2:
        TDIR = sys.argv[2]
        for i in files:
            move(i, TDIR)
        sys.exit(0)
