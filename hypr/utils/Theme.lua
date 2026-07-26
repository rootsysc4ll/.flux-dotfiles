local json = require "utils.json"

local jsonFile = os.getenv("HOME") .. "/.flux-dotfiles/Theme.json"
io.input(jsonFile)

local jsonData = io.read("*all")

io.close()

Theme = json.decode(jsonData)