#!/usr/bin/env lua
-- This script gets rid of duplicate lines in a playcount file by adding
-- any duplicate entry to the first entry. It is automatically invoked by the
-- plfix script.

musicdir = os.getenv('HOME')..'/Music/'
fpath = arg[1]
pretend = (arg[2] == '1')
hashset = {}
hashset_order = {}
dupes = 0
header = false

for line in io.lines(fpath) do
	local f = line:gmatch('[^\t]*')
	local num, song = tonumber(f()), f()

	f = io.open(musicdir..song, 'r')
	if f == nil then
		if not header then
			print(fpath:gsub(musicdir, '')..'')
			header = true
		end
		print(num, song)
	else
		f:close()
		if not hashset[song] then
			hashset_order[#hashset_order + 1] = song
		else
			dupes = dupes + 1
		end
		hashset[song] = (hashset[song] or 0) + num
	end
end

if not pretend then
	fout = io.open(fpath, 'w')
	for _, v in ipairs(hashset_order) do
		fout:write(('%d\t%s\n'):format(hashset[v], v))
	end
	fout:close()
end

if dupes ~= 0 then
	io.stderr:write(("%s %d duplicate line%s in '"..fpath:gsub(musicdir, '').."'\n"):format(
		pretend and 'Found' or 'Merged',
		dupes,
		dupes == 1 and '' or 's'
	))
end
