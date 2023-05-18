#!/usr/bin/env lua

-- Supplementary script for plfilter.
-- Reads from stdin input of the form:
--      +playlist1
--      +playlist2
--      -playlist3
--      +playlist4
--      ...
-- Prints out a filtered playlist in which all songs simultaneously belong to
-- all '+' playlists and don't belong to any of '-' playlists.
-- In case of an empty file, all files in the music library will be returned
-- (this requires mpc installed and an up-to-date MPD database).

MUSIC_DIR = os.getenv('HOME')..'/Music/'
hashset = {}
isfirst = true
for playlist in io.stdin:lines() do
    if isfirst then
        if playlist:sub(1, 1) == '+' then
            for song in io.lines(playlist:sub(2)) do
                hashset[song] = true
            end
        else
            local f = assert(io.popen(("cd '%s' && find . -type f -name '*.mp3'"):format(MUSIC_DIR), 'r'))
            local output = f:read('*a')
            f:close()
            for song in output:gmatch('[^\n]*') do
                local song = song:sub(3)
                if #song ~= 0 then hashset[song] = true end
            end
        end
        isfirst = false
    else
        if playlist:sub(1, 1) == '+' then
            local to_unify = {}
            for song in io.lines(playlist:sub(2)) do
                to_unify[song] = true
            end
            for k, _ in pairs(hashset) do
                if not to_unify[k] then
                    hashset[k] = nil
                end
            end
        elseif playlist:sub(1, 1) == '-' then
            for song in io.lines(playlist:sub(2)) do
                hashset[song] = nil
            end
        end
    end
end
if isfirst then
	os.execute(("mpc listall"))
end
for k, _ in pairs(hashset) do
    print(k)
end
