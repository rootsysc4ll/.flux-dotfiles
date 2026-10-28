local THEME_DIR = os.getenv("FLUX") .. "/theme"

package.path = THEME_DIR .. "/?.lua;" .. package.path

local json = require("json")
local themeConfig = {}

local themeJsonFile = io.open(THEME_DIR .. "/Theme.json", "r")
if themeJsonFile then
	themeConfig = json.decode(themeJsonFile:read("*a"))
end

return themeConfig