#!/usr/bin/env lua

-- A supplementary script for plgen. It requires a list of song paths to choose
-- from delimited by newlines on standard input. The resulting playlist is
-- printed on standard output. If standard input is empty, all the available
-- songs will be considered.
--
-- Usage:
--     plgen N|TIME
-- The first argument is either an integer denoting the number of tracks to put
-- in the playlist, or a time indication in format [HH:]MM:[SS] denoting the
-- desired length of the playlist (the exact lenght will vary somewhat).

local lfs = require('lfs')

--------------------------
-- GLOBAL CONFIGURATION --
--------------------------
MUSIC_DIR = os.getenv('HOME')..'/Music/'
PLAYLIST_DIR = MUSIC_DIR..'Playlists/'
BPM_TOLERANCE = 0.05
CANDIDATE_STRICTNESS = 0.5

-- Aside from '_', '@' and '!'-prefixed playlists, this hashset
-- can include other ones that will be used for comparing songs
PLAYLIST_WHITELIST = {
	['#Fast'] = true,
	['#Slow'] = true,
	['#Lo-Fi'] = true,
	['#Bass'] = true,
	['#Keys'] = true,
	['#Rap'] = true,
}

-- By convention the '.' playlists entry contains all usable songs
local was_stdin_empty = true
songs, playlists = {}, {['.'] = {}}
for line in io.stdin:lines() do
	playlists['.'][#playlists['.'] + 1] = line
	was_stdin_empty = false
end

function load_data()
	-- Temporary hashset to find unavailable songs
	local unavailable_songs = {}
	if not was_stdin_empty then
		for _, song in ipairs(playlists['.']) do
			unavailable_songs[song] = true
		end
	end

	-- Read song transitions
	for line in io.lines(MUSIC_DIR..'transitions.tsv') do
		local song, bpm, mood, iter = nil, {}, {}, line:gmatch('[^\t]*')
		song = iter()
		if was_stdin_empty and unavailable_songs[song] then
			goto continue
		end
		bpm[1] = tonumber(iter())
		bpm[2] = tonumber(iter())
		mood[1] = tonumber(iter())
		mood[2] = tonumber(iter())
		if (song and bpm[1] and bpm[2] and mood[1] and mood[2]) == nil then
			goto continue
		end
		songs[song] = {bpm = bpm, mood = mood, playcount = 0, playlists = {}}
		if was_stdin_empty then
			playlists['.'][#playlists['.']  + 1] = song
		else
			unavailable_songs[song] = nil
		end
		::continue::
	end

	if not was_stdin_empty then
		-- Warn about unavailable songs
		for song, _ in pairs(unavailable_songs) do
			io.stderr:write('plgen: file "'..song..'" missing metadata, skipping\n')
		end

		-- Filter unavailable songs out of the available list
		local playlists_new = {}
		for _, song in ipairs(playlists['.']) do
			if not unavailable_songs[song] then
				playlists_new[#playlists_new + 1] = song
			end
		end
		playlists['.'] = playlists_new
	end
	unavailable_songs = nil

	-- Read song playcounts
	local cmd = io.popen('plrare .', 'r')
	assert(cmd)
	for line in cmd:lines() do
		local song, playcount, iter
		iter = line:gmatch('[^\t]*')
		playcount = tonumber(iter())
		song = iter()
		if (song and playcount) == nil or songs[song] == nil then
			goto continue
		end
		songs[song].playcount = playcount
		::continue::
	end
	cmd:close()

	-- Read playlists
	for file in lfs.dir(PLAYLIST_DIR) do
		local prefix, attr = file:sub(1, 1), nil
		if PLAYLIST_WHITELIST[file] == nil then
			if prefix ~= '_' and prefix ~= '@' and prefix ~= '!' then
				goto continue
			end
			attr = lfs.attributes(PLAYLIST_DIR..file)
			if attr.mode == 'directory' then
				goto continue
			end
		end
		playlists[file] = {}
		for song in io.lines(PLAYLIST_DIR..file) do
			if songs[song] ~= nil then
				songs[song].playlists[#songs[song].playlists + 1] = file
				playlists[file][song] = true
			end
		end
		::continue::
	end
end

function parse_args()
	local ret = {ntracks = nil, seconds = nil}
	if #arg ~= 1 then
		io.stderr:write('plgen: exactly 1 argument expected\n')
		return
	end
	ret.ntracks = arg[1]:match('^%d+$')
	if ret.ntracks ~= nil then
		return ret
	end

	-- Extract hours, minutes and seconds
	local h, m, s
	local a, b, c = arg[1]:match('(%d+):(%d+):(%d+)')
	if (a and b and c) ~= nil then
		h, m, s = tonumber(a), tonumber(b), tonumber(c)
	else
		local a, b = arg[1]:match('(%d+):(%d+)')
		if (a and b) ~= nil then
			h, m, s = 0, tonumber(a), tonumber(b)
		else
			local a = arg[1]:match('(%d+):')
			if a ~= nil then
				h, m, s = 0, tonumber(a), 0
			end
		end
	end
	ret.seconds = h * 3600 + m * 60 + s
	return ret
end

function generate_playlist(params)
	local playlist = {}

	local function add_song()
		local candidates = {}

		-- Compile a list of candidates
		for index, song in ipairs(playlists['.']) do
			local s0, s1 = songs[playlist[#playlist]], songs[song]

			-- Filter out by BPM
			local ratio = s0.bpm[2] >= s1.bpm[1]
				and s0.bpm[2] / s1.bpm[1] % 1
				or s1.bpm[1] / s0.bpm[2] % 1
			if ratio > BPM_TOLERANCE and 1 - ratio > BPM_TOLERANCE then
				goto continue
			end

			-- Filter out by mood
			if math.abs(s0.mood[2] - s1.mood[1]) > 1 then
				goto continue
			end

			candidates[#candidates + 1] = {index, song}
			::continue::
		end

		-- Pick a candidate
		if #candidates ~= 0 then
			-- Sort candidates based on playlists similarity
			local function comp(a, b)
				local a_dist, b_dist
				a, b = a[2], b[2]
				local a_pls, b_pls = songs[a].playlists, songs[b].playlists

				-- Count how many playlists a and b have in common with the
				-- previous song.
				local hashset, a_common, b_common = {}, 0, 0
				for _, v in ipairs(songs[playlist[#playlist]].playlists) do
					hashset[v] = true
				end
				for _, v in ipairs(a_pls) do
					a_common = a_common + (hashset[v] and 1 or 0)
				end
				for _, v in ipairs(b_pls) do
					b_common = b_common + (hashset[v] and 1 or 0)
				end

				-- Use sine function to quantify the fit - too many playlists
				-- in common is not good, because it leads to poor diversity.
				-- Too few playlists in common is also not good, because it
				-- leads to weird transitions. The sine range [0, pi] is
				-- stretched over the domain [0, n], where n is the number of
				-- playlists the song is in (the smaller of the two). As such,
				-- the function maximum lies at x == n/2. To convert similarity
				-- to distance, the result is subtracted from 1.
				local n = #a_pls <= #b_pls and #a_pls or #b_pls
				if n ~= 0 then
					a_dist = 1 - math.sin(a_common * math.pi / n)
					b_dist = 1 - math.sin(b_common * math.pi / n)
				else
					a_dist = 1
					b_dist = 1
				end

				-- Break ties: if a and b are equally similar to the previous
				-- song, prioritize the one which does not come from the same
				-- directory (i.e. different artist), if possible. If that
				-- doesn't clarify a winner, pick whichever has less plays.
				if a_dist == b_dist then
					local prev, adir, bdir = playlist[#playlist], a, b
					prev = prev:sub(1, prev:find('/') - 1)
					adir = adir:sub(1, adir:find('/') - 1)
					bdir = bdir:sub(1, bdir:find('/') - 1)
					if bdir == prev then
						if adir ~= prev then
							return true
						else
							return songs[a].playcount < songs[b].playcount
						end
					end
					return false
				end
				return a_dist < b_dist
			end
			table.sort(candidates, comp)

			-- Select winner (top candidates have higher chance)
			local index = 1
			while math.random() < CANDIDATE_STRICTNESS do
				if index == #candidates then
					break
				end
				index = index + 1
			end
			local winner = candidates[index]
			playlist[#playlist + 1] = winner[2]
			table.remove(playlists['.'], winner[1])
		else
			local index = math.random(#playlists['.'])
			playlist[#playlist + 1] = playlists['.'][index]
			table.remove(playlists['.'], index)
			io.stderr:write('No candidates after '..playlist[#playlist - 1]..', picked '..playlist[#playlist]..' at random.\n')
		end
	end

	-- Pick random starting point
	local index, duration, last_duration = math.random(#playlists['.']), 0, 0
	playlist[1] = playlists['.'][index]
	table.remove(playlists['.'], index)
	local duration_fname = ("mp3info -p %%S '%s'"):format(MUSIC_DIR..playlist[1]:gsub("'", "'\"'\"'"))
	local duration_file = assert(io.popen(duration_fname))
	duration = assert(tonumber(duration_file:read('*a')))

	if params.ntracks ~= nil then
		for _ = 2, params.ntracks do
			last_duration = duration
			add_song()
			local tmp = io.popen(("mp3info -p %%S '%s'"):format(MUSIC_DIR..playlist[#playlist]:gsub("'", "'\"'\"'")))
			assert(tmp)
			duration = duration + tonumber(tmp:read('*a'))
		end
	elseif params.seconds ~= nil then
		while duration < params.seconds do
			last_duration = duration
			add_song()
			local tmp = io.popen(("mp3info -p %%S '%s'"):format(MUSIC_DIR..playlist[#playlist]:gsub("'", "'\"'\"'")))
			assert(tmp)
			duration = duration + tonumber(tmp:read('*a'))
		end
		-- Remove the last track if it will make it closer to the goal
		if math.abs(last_duration - params.seconds) < math.abs(duration - params.seconds) then
			table.remove(playlist)
		end
	end
	return playlist
end

load_data()
local params = parse_args()
if params == nil then
	os.exit(1)
end
local pl = generate_playlist(params)
for _, v in ipairs(pl) do
	print(v)
end
