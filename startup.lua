-- Grab using
-- wget https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/startup.lua

local url = "" --url goes here
local file = "main.lua"

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

download(url, file)
shell.run(file)