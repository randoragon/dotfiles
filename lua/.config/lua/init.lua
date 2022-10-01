-- sources: https://gist.github.com/hashmal/874792
--          https://gist.github.com/xytis/5361405
function tprint (tbl, indent)
	indent = indent or 0
	for k, v in pairs(tbl) do
		if type(k) ~= 'table' then
			io.write(string.rep('  ', indent)..k..':')
		else
			print(string.rep('  ', indent)..'{')
			tprint(k, indent + 1)
			io.write(string.rep('  ', indent)..'}:')
		end
		if type(v) == 'table' then
			print()
			tprint(v, indent + 1)
		else
			print(' '..tostring(v))
		end
	end
end
