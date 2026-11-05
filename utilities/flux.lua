local CONFIG_DIR = os.getenv("FLUX") .. "/utilities"
package.path = CONFIG_DIR .. "/?.lua;" .. package.path

local json = require("json")
local JSON_CONFIG_FILEPATH = CONFIG_DIR .. "/fluxConfig.json"
local CONFIG_MODULE_FILE = "fluxConfig"

local function jsonPrettier(jsonStr, indentChar, indentSize)
    indentChar = indentChar or " "
    indentSize = indentSize or 4

    local currentIndent = 0
    local result = {}
    local in_string = false
    local escaped = false

    local tokens = {}
    for i = 1, #jsonStr do
        local char = jsonStr:sub(i, i)
        if char == '"' and not escaped then
            in_string = not in_string
            table.insert(tokens, char)
        elseif in_string then
            if char == "\\" and not escaped then
                escaped = true
            else
                escaped = false
            end
            table.insert(tokens, char)
        elseif not char:match("%s") then
            table.insert(tokens, char)
        end
    end
    local clean_json = table.concat(tokens)

    local i = 1
    in_string = false
    escaped = false

    while i <= #clean_json do
        local char = clean_json:sub(i, i)

        if char == '"' and not escaped then
            in_string = not in_string
            table.insert(result, char)
        elseif in_string then
            if char == "\\" and not escaped then
                escaped = true
            else
                escaped = false
            end
            table.insert(result, char)
        else
            if char == "{" or char == "[" then
                currentIndent = currentIndent + 1
                table.insert(result, char .. "\n" .. string.rep(indentChar, currentIndent * indentSize))
            elseif char == "}" or char == "]" then
                currentIndent = currentIndent - 1
                local last = result[#result]
                if last and last:match("\n%s*$") then
                    table.remove(result)
                end
                table.insert(result, "\n" .. string.rep(indentChar, currentIndent * indentSize) .. char)
            elseif char == "," then
                table.insert(result, ",\n" .. string.rep(indentChar, currentIndent * indentSize))
            elseif char == ":" then
                table.insert(result, ": ")
            else
                table.insert(result, char)
            end
        end
        i = i + 1
    end

    return table.concat(result)
end

local function saveJson(data)
    local encoded = json.encode(data)
    local prettier = jsonPrettier(encoded)

    -- the assertion is made because, in order to this function be called. fluxJsonFile certainly exists
    local f = assert(io.open(JSON_CONFIG_FILEPATH, "w"))
    f:write(prettier)
    f:close()

    return encoded
end

local function createDefaultFluxJsonFile()
    local rawJSON = '{\n\t"awww": {\n\t\t"--transition-type": "any",\n\t\t"--transition-duration": 2\n\t},\n\t"wal": {\n\t\t"-a": 0\n\t},\n\t"themes": [\n\t\t{\n\t\t\t"name": "default",\n\t\t\t"image": ' .. '"' .. CONFIG_DIR .. '/default.png",\n\t\t\t"mode": "dark"\n\t\t}\n\t]\n}'

    local f = assert(io.open(JSON_CONFIG_FILEPATH, "w+")) -- assertion because the file creation is forced
    f:write(rawJSON)
    f:close()

    return "Created default config file, run the cli again if this wasn't expected."
end

-- iteretates the themes in the config searching for an index matching the name, so tecnically checks if the theme exists
local function checkIfThemeExists(name, fluxConfigThemes)
    for i, theme in ipairs(fluxConfigThemes) do
        if theme.name == name then
            return i -- returns the index matching the name 
        end
    end

    return -1
end

local function createTheme(newTheme, fluxConfig)
    if not newTheme.name or not newTheme.image or not newTheme.mode then
        return "Please provide a name, an image path and a mode for the theme."
    end

    local targetIndex = checkIfThemeExists(newTheme.name, fluxConfig.themes)

    if targetIndex > 0 then
        return "A theme with the same name already exists."
    else
        table.insert(fluxConfig.themes, {
            name = newTheme.name,
            image = newTheme.image,
            mode = newTheme.mode
        })
        fluxConfig.numberOfThemes = #fluxConfig.themes

        saveJson(fluxConfig)
        os.execute("hyprctl reload")

        return "Created new theme."
    end
end

local function removeTheme(name, fluxConfig)
    local targetIndex = checkIfThemeExists(name, fluxConfig.themes)

    if targetIndex > 0 then
        table.remove(fluxConfig.themes, targetIndex)
        saveJson(fluxConfig)

        return "Theme removed."
    else
        return "No name found for the given name."
    end
end

local function setUtilityArgument(utilityName, targetedArg, value, fluxConfig)
    if not fluxConfig[utilityName] then
        return [[The config doesn't support the utility "]] .. utilityName .. [[".]]
    elseif not fluxConfig[utilityName][targetedArg] then
        return [[The config doesn't support the argument "]] .. targetedArg .. [[" for the utility "]] .. utilityName .. [[".]]
    else
        fluxConfig[utilityName][targetedArg] = value

        saveJson(fluxConfig)
        return [[Changed argument "]] .. targetedArg .. [[" of utility "]] .. utilityName .. [[" to "]] .. value .. [[".]]
    end
end

local function getThemes(fluxConfigThemes)
    local encoded = json.encode(fluxConfigThemes)
    local prettier = jsonPrettier(encoded)

    return prettier
end

local function getConfigJson(fluxConfig)
    local encoded = json.encode(fluxConfig)
    local prettier = jsonPrettier(encoded)

    return prettier
end

local function loadTheme(themeIndex, fluxConfig, numeberOfThemes)
    if not themeIndex or themeIndex > numeberOfThemes or themeIndex < 0 then
        return "That's an invalid index or this theme doesn't exists."
    end

    local theme = fluxConfig.themes[themeIndex]
    local image = theme.image
    local mode  = theme.mode == "light" and " -l" or ""
    local command =(
        "awww img "                  .. image
        .. " --transition-type "     .. fluxConfig.awww["--transition-type"]
        .. " --transition-duration " .. fluxConfig.awww["--transition-duration"]
        .. " && "
        .. "wal -n " .. mode
        .. " -i "    .. image
        .. " -a "    .. fluxConfig.wal["-a"]
    )

    local result = os.execute(command)

    if result then
        return "(flux): The config was succesfully loaded."
    else
        return "(flux): Some error occured and the config wasn't loaded."
    end
end

local function cli(args)
    -- this is a special argument that don't need the module
    if args[1] == "-d" or args[1] == "--default" then
        return createDefaultFluxJsonFile()
    end

    local fluxConfig = require(CONFIG_MODULE_FILE)

    for i, arg in ipairs(args) do
        if arg == "-c" or arg == "--create"          then
            return createTheme({
                name  = args[i + 1],
                image = args[i + 2],
                mode  = args[i + 3]
            }, fluxConfig)
        elseif arg == "-r" or arg == "--remove"          then
            return removeTheme(args[i + 1], fluxConfig)
        elseif arg == "-a" or arg == "--set-utility-arg" then
            return setUtilityArgument(
                args[i + 1],
                args[i + 2],
                args[i + 3],
                fluxConfig
            )
        elseif arg == "-p" or arg == "--print-themes"    then
            return getThemes(fluxConfig.themes)
        elseif arg == "--config"                         then
            return getConfigJson(fluxConfig)
        elseif arg == "load"                             then
            return loadTheme(tonumber(args[i + 1]), fluxConfig, #fluxConfig.themes)
        else
            return "Unknown argument."
        end
    end
end

-- this is the entry for the program
local function main(argv)
    local fluxJsonFile = io.open(JSON_CONFIG_FILEPATH, "r+") -- the only purpose of this is to test wether fluxConfig.json exists

    if fluxJsonFile then
        fluxJsonFile:close()
        print(
            cli(argv)
        )
    else
        print("Json file does not exists, creating one...")
        print(
            createDefaultFluxJsonFile()
        )
    end
end

main({...})