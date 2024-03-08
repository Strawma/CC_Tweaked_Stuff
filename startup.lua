-- Grab using
-- wget https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/startup.lua

local url = "" --url goes here
local file = "main.lua"

local function getChannel()
    local fileName = "CHANNEL.txt"
    if fs.exists(file) then
        local file = fs.open(fileName, "r")
        channel = file.readLine()
        file.close()
    else
        local file = fs.open(fileName, "w")
        repeat
            write("Enter the channel number: ")
            channel = read()
        until tonumber(channel)
        file.write(channel)
        file.close()
    end
    return tonumber(channel)
end

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

download(url, file)
shell.run(file)