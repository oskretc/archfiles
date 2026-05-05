-- require("folder-rules"):setup()
require("full-border"):setup()
require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
-- Header:children_add(function()
-- 	if ya.target_family() ~= "unix" then
-- 		return ""
-- 	end
-- 	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
-- end, 500, Header.LEFT)
