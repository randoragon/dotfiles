#!/usr/bin/env lua
-- Used by plrare script to quickly merge playcount files.

playcount = {}
for _, fpath in ipairs(arg) do
	for line in io.lines(fpath) do
		local file, count = line:gsub('.*\t', ''), line:gsub('\t.*', '')
		playcount[file] = (playcount[file] or 0) + count
	end
end
for file, count in pairs(playcount) do
	print(count..'\t'..file)
end
