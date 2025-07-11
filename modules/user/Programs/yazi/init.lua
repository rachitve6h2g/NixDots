-- For full-border plugin
require("full-border"):setup {
  type = ui.Border.ROUNDED, 
}

-- for git.yazi
require("git"):setup()
-- Modifications of color
th.git = th.git or {}
th.git.modified = ui.Style():fg("#9ccfd8")
th.git.deleted = ui.Style():fg("#eb6f92")

-- ~/.config/yazi/init.lua
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
