#!/usr/bin/env lua

local lfs = require("lfs")

MUSICDIR = os.getenv("HOME") .. "/Music"
PLDIR = MUSICDIR .. "/Playlists"
LOG = (os.getenv("XDG_DATA_DIR") or (os.getenv("HOME") .. "/.local/share")) .. "/plfix-latest.log"

local pretend = (arg[1] == "-p" or arg[1] == "--pretend")

-- Classes
local Track = {}
local Playlist = {}

-- Class methods
function Track:new(fpath)
	local o = {
		file = fpath, -- Path to the audio file, relative to `MUSICDIR`
		exists = false, -- Whether the file at `path` exists
		count = 1, -- The number of occurrences in a file
	}
	local f = io.open(fpath, "r")
	if f then
		io.close(f)
		o.exists = true
	end
	setmetatable(o, self)
	self.__index = self
	return o
end

function Playlist:new(fpath)
	local o = {
		tracks = {}, -- List of `Track`s
		duplicates = {}, -- Cached list of indices to `tracks` where count > 1
		track_indices = {}, -- Reverse mapping from track file to `tracks` index
	}
	setmetatable(o, self)
	self.__index = self
	for line in io.lines(fpath) do
		if o.filenames[line] == nil then
			-- Append new track to playlist
			local track = Track:new(line)
			o.tracks[#o.tracks + 1] = track
			o.track_indices[line] = #o.tracks
		else
			-- Increment counter and mark track as duplicate
			local track_idx = o.track_indices[line]
			local track = o.tracks[track_idx]
			track.count = track.count + 1
			o.duplicates[track_idx] = true
		end
	end
	return o
end
