#!/usr/bin/env lua
-- This script gets rid of duplicate lines in playcount.tsv by adding any
-- duplicate entry to the first entry. It can be used on its own and is
-- automatically invoked by the plfix script.

musicdir = os.getenv('HOME') .. '/Music/'
fpath = musicdir .. 'playcount.tsv'
hashset = {}
hashset_order = {}
dupes = 0

for line in io.lines(fpath) do
	local f = line:gmatch('[^\t]*')
	local num, song = tonumber(f()), f()
	if not hashset[song] then
		hashset_order[#hashset_order + 1] = song
    else
        dupes = dupes + 1
    end
	hashset[song] = (hashset[song] or 0) + num
end

fout = io.open(fpath, 'w')
for _, v in ipairs(hashset_order) do
	fout:write(string.format('%d\t%s\n', hashset[v], v))
end
fout:close()

if dupes == 0 then
    print('No duplicate lines in playcount.tsv')
else
    print(string.format('Merged %d duplicate line%s in playcount.tsv', dupes, dupes == 1 and '' or 's'))
end
