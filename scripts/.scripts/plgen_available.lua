#!/usr/bin/env lua

-- A supplementary script for plgen. It intakes a newline-separated list of
-- paths to music files (relative to MUSIC_DIR) and outputs only those items
-- which have full information needed for plgen (start & end BPMs and moods).

MUSIC_DIR = os.getenv('HOME')..'/Music/'

playlist = {}
for line in io.stdin:lines() do
	playlist[#playlist + 1] = line
end

local unavailable_songs = {}
for _, song in ipairs(playlist) do
	unavailable_songs[song] = true
end

for line in io.lines(MUSIC_DIR..'transitions.tsv') do
	local song, bpm, mood, iter = nil, {}, {}, line:gmatch('[^\t]*')
	song = iter()
	bpm[1] = tonumber(iter())
	bpm[2] = tonumber(iter())
	mood[1] = tonumber(iter())
	mood[2] = tonumber(iter())
	if (song and bpm[1] and bpm[2] and mood[1] and mood[2]) == nil then
		goto continue
	end
	unavailable_songs[song] = nil
	::continue::
end

for _, song in ipairs(playlist) do
	if not unavailable_songs[song] then
		print(song)
	end
end
