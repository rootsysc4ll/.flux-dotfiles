local CONFIG_DIR = os.getenv("FLUX") .. "/flux"
package.path = CONFIG_DIR .. "/?.lua;" .. package.path

local JSON_CONFIG_FILEPATH = CONFIG_DIR .. "/fluxConfig.json"
local json = require("json")

local function checkIfConfigExists()
    local f = io.open(JSON_CONFIG_FILEPATH, "r+")
    if not f then
        os.execute('fish -c "flux -d"')
    else
        f:close()
    end
end

local function getConfig()
    local configFile = assert(io.open(JSON_CONFIG_FILEPATH, "r+"))
    local fluxConfig = json.decode(configFile:read("*a"))
    configFile:close()

    return fluxConfig
end

checkIfConfigExists()
return getConfig()