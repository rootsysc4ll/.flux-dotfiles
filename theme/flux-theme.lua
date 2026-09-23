local theme_dir = os.getenv("FLUX") .. "/theme"
package.path = theme_dir .. "/?.lua;" .. theme_dir .. "/?/init.lua;" .. package.path

require("Theme")

local theme = Theme
local themeFileName = theme_dir .. "/Theme.lua" -- this exists for development purposes only
local args = {...}

local function writeToFile(content)
    local f = io.open(themeFileName, "w")
    if f then
        f:write(content)
        f:close()

        return true
    else
        print("Error trying to open file")
    end

    return false
end

local function stringfy()
    local stringfied = "Theme = {\n"

    for i, themeObj in ipairs(theme) do
        stringfied = string.format('%s\t{\n\t\tname = "%s",\n\t\twpPath = "%s",\n\t\tmode = "%s"\n\t},\n',
                        stringfied, themeObj.name, themeObj.wpPath, themeObj.mode)
    end
    stringfied = stringfied .. "}"

    return writeToFile(stringfied)
end

local function parse()
    for i, arg in ipairs(args) do
        args[i] = arg:match("^[%s,%[%]]*(.-)[%s,%[%]]*$")
    end
end

local function createDefaultTheme()
    if writeToFile(
[[Theme = {
    {
        name = "default",
        wpPath = "~/.flux-dotfiles/theme/default.png",
        mode = "dark"
    }
}]]) then
        print("Default theme created")
    end

end

local function createTheme(name, wpPath, mode)
    table.insert(theme, {
        name = name,
        wpPath = wpPath,
        mode = mode
    })

    if stringfy() then
        print("New theme added")
    end
end

local function removeTheme(name)
    local targetIndex = 0
    for i, themeObj in ipairs(theme) do
        print(themeObj.name)
        if themeObj.name == name then
            targetIndex = i
            break
        end
    end

    if targetIndex > 0 then
        table.remove(theme, targetIndex)
    else
        print("Name not found")
        return false
    end

    if stringfy() then
        print("Theme removed")
    end
end

local function cli()
    if args[1] == "default" then
        createDefaultTheme()
    elseif args[1] == "create" then
        parse()
        createTheme(args[2], args[3], args[4])
    elseif args[1] == "remove" then
        removeTheme(args[2])
    else
        print("Unknown option")
    end
end

cli()