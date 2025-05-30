-- Matcher for macro tda (`ttdl add` shorthand)

local function getprojects()
	local handle = io.popen("cd %USERPROFILE% & ttdl lp")
	if handle == nil then
		return {}
	end
	local output = handle:read("*a")
	if output == nil then
		return {}
	end
	local projects = {}
	for w in string.gmatch(output, "%w+") do
		table.insert(projects, "+" .. w)
	end
	handle:close()
	return projects
end

---@diagnostics disable-next-line:undefined-global
clink.argmatcher("tda"):addflags(getprojects())
