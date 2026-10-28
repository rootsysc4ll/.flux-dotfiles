local json = require("json")
local THEME_JSON_FILE_PATH = os.getenv("FLUX") .. "/theme/Theme.json"

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

local function saveJSON(data)
    local encoded = json.encode(data)
    local prettier = jsonPrettier(encoded)

    -- the assertion is made because, in order to this function be called. themeJsonFile certainly exists
    local f = assert(io.open(THEME_JSON_FILE_PATH, "w"))
    f:write(prettier)
    f:close()

    return encoded
end

local function createDefaultThemeJsonFile()
    local rawJSON = '{\n\t"awww": {\n\t\t"--transition-type": "any",\n\t\t"--transition-duration": 2\n\t},\n\t"wal": {\n\t\t"-a": 0\n\t},\n\t"themes": [\n\t\t{\n\t\t\t"name": "default",\n\t\t\t"wpPath": "~/.flux-dotfiles/theme/default.png",\n\t\t\t"mode": "dark"\n\t\t}\n\t]\n}'

    local f = assert(io.open(THEME_JSON_FILE_PATH, "w+")) -- assertion because the file creation is forced
    f:write(rawJSON)
    f:close()

    return "Created default json theme file"
end

-- iteretates the themes in the config searching for an index matching the name, so tecnically checks if the theme exists
local function checkIfThemeExists(name, themeConfigThemes)
    for i, theme in ipairs(themeConfigThemes) do
        if theme.name == name then
            return i -- returns the index matching the name 
        end
    end

    return -1
end

local function createTheme(newTheme, themeConfig)
    local targetIndex = checkIfThemeExists(newTheme.name, themeConfig.themes)

    if targetIndex > 0 then
        return "A theme with the same name already exists"
    else
        table.insert(themeConfig.themes, {
            name = newTheme.name,
            wpPath = newTheme.wpPath,
            mode = newTheme.mode
        })

        saveJSON(themeConfig)
        return ("Created new theme")
    end
end

local function removeTheme(name, themeConfig)
    local targetIndex = checkIfThemeExists(name, themeConfig.themes)

    if targetIndex > 0 then
        table.remove(themeConfig.themes, targetIndex)
        saveJSON(themeConfig)

        return "Theme removed."
    else
        return "No name found for the given name."
    end
end

local function setUtilityArgument(utilityName, targetedArg, value, themeConfig)
    if not themeConfig[utilityName] then
        return [[The config doesn't support the utility "]] .. utilityName .. [[".]]
    elseif not themeConfig[utilityName][targetedArg] then
        return [[The config doesn't support the argument "]] .. targetedArg .. [[" for the utility "]] .. utilityName .. [[".]]
    else
        themeConfig[utilityName][targetedArg] = value

        saveJSON(themeConfig)
        return [[Changed argument "]] .. targetedArg .. [[" of utility "]] .. utilityName .. [[" to "]] .. value .. [[".]]
    end
end

local function printThemes(themeConfigThemes)
    local encoded = json.encode(themeConfigThemes)
    local prettier = jsonPrettier(encoded)

    print(prettier)
end

local function printConfig(themeConfig)
    local encoded = json.encode(themeConfig)
    local prettier = jsonPrettier(encoded)

    print(prettier)
end

local function cli(args)
    local themeConfig = require("Theme")

    if themeConfig == {} then
        return error("themeConfig is empty. Closing the cli...")
    end

    if     args[1] == "-d" or args[1] == "--default"         then
        print(
            createDefaultThemeJsonFile()
        )
    elseif args[1] == "-c" or args[1] == "--create"          then
        print(
            createTheme({
                name = args[2],
                wpPath = args[3],
                mode = args[4]
            }, themeConfig)
        )
    elseif args[1] == "-r" or args[1] == "--remove"          then
        print(
            removeTheme(args[2], themeConfig)
        )
    elseif args[1] == "-a" or args[1] == "--set-utility-arg" then
        print(
            setUtilityArgument(args[2], args[3], args[4], themeConfig)
        )
    elseif args[1] == "-p" or args[1] == "--print-themes"    then
        printThemes(themeConfig.themes)
    elseif args[1] == "--config"                             then
        printConfig(themeConfig)
    else
        print("Unknown option.")
    end
end

local args = {...}
local themeJsonFile = io.open(THEME_JSON_FILE_PATH, "r+") -- the only purpose of this is to test wether Theme.json exists

if themeJsonFile then
    themeJsonFile:close()
    cli(args)
else
    print("Json file does not exists, creating one...")
    print(
        createDefaultThemeJsonFile()
    )
end