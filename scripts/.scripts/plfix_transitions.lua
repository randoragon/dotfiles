#!/usr/bin/env lua
-- This script gets rid of duplicate lines in transitions.tsv by merging them
-- into a single entry. Any first occurrence of a song is taken as the "base"
-- entry. Each subsequent entry of the same song is merged into base according
-- to the following rules:
-- 1) copy into the base all fields which base does not have,
-- 2) if both the base and a subsequent entry have a field, keep base's value
-- This script is automatically invoked by the plfix script.

musicdir = os.getenv('HOME')..'/Music/'
fpath = musicdir..'transitions.tsv'
pretend = (arg[1] == '1')
hashset = {}
hashset_order = {}
dupes = 0
header = false

for line in io.lines(fpath) do
	local f = line:gmatch('[^\t]*')
	local song, bpm1, bpm2, mood1, mood2 = f(), f(), f(), f(), f()

	f = io.open(musicdir..song, 'r')
	if f == nil then
		if not header then
			print(fpath:gsub(musicdir, '')..'')
			header = true
		end
		print('', song, bpm1, bpm2, mood1, mood2)
	else
		f:close()
		if not hashset[song] then
			hashset_order[#hashset_order + 1] = song
			hashset[song] = {bpm1, bpm2, mood1, mood2}
		else
			hashset[song][1] = hashset[song][1] ~= '' and hashset[song][1] or bpm1
			hashset[song][2] = hashset[song][2] ~= '' and hashset[song][2] or bpm2
			hashset[song][3] = hashset[song][3] ~= '' and hashset[song][3] or mood1
			hashset[song][4] = hashset[song][4] ~= '' and hashset[song][4] or mood2
		dupes = dupes + 1
		end
	end
end

if not pretend then
	fout = io.open(fpath, 'w')
	for _, v in ipairs(hashset_order) do
		fout:write(('%s\t%s\t%s\t%s\t%s\n'):format(v, table.unpack(hashset[v])))
	end
	fout:close()
end

if dupes == 0 then
	io.stderr:write('No duplicate lines in transitions.tsv\n')
else
	io.stderr:write(('%s %d duplicate line%s in transitions.tsv\n'):format(
		pretend and 'Found' or 'Merged',
		dupes,
		dupes == 1 and '' or 's'
	))
end
