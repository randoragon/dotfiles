#!/usr/bin/env lua
-- Used by the plrare script to get a list of all songs ranked by playcount.
-- The order of songs is random within each group, making it trivial to extract
-- N most/least played songs.

MUSICDIR = os.getenv('HOME')..'/Music/'

playcount = {}
max = 0
for file in io.stdin:lines() do
	playcount[file] = 0
end
for _, fpath in ipairs(arg) do
	for line in io.lines(fpath) do
		local file, count = line:gsub('.*\t', ''), line:gsub('\t.*', '')
		if playcount[file] ~= nil then
			playcount[file] = playcount[file] + count
			max = math.max(max, playcount[file])
		else
			print('plrare: the following file appears on a playcount, but is not a part of the MPD library:', file)
		end
	end
end

-- Transform from song->count mapping to count->{song...} mapping
lists = {}
for i = 0, max do
	lists[i] = {}
end
for file, count in pairs(playcount) do
	lists[count][#lists[count] + 1] = file
end

-- Print all songs, order randomized within each count group
math.randomseed(os.time())
for i = 0, #lists do
	if #lists[i] ~= 0 then
		for j = 1, #lists[i]-1 do
			local index = math.random(j, #lists[i])
			print(i, lists[i][index])
			lists[i][index] = lists[i][j]
		end
		print(i, lists[i][#lists[i]])
	end
end
