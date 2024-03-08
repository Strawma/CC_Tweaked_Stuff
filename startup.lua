-- Grab using
-- wget https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/startup.lua

local url = "" --url goes here
local file = "main.lua"

local apiUrl = "https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/strawma-api.lua"
local apiFile = "strawma-api.lua"

local function setChannel()
    local fileName = "CHANNEL.txt"
    local validChannel = false
    if fs.exists(fileName) then
        local file = fs.open(fileName, "r")
        local channel = file.readLine()
        file.close()
        if tonumber(channel) then
            validChannel = true
        end
    end
    if not validChannel then
        local file = fs.open(fileName, "w")
        local channel
        repeat
            write("Enter the channel number: ")
            channel = read()
            print()
        until tonumber(channel)
        file.write(channel)
        file.close()
    end
end

setChannel()

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

download(apiUrl, apiFile)
download(url, file)
shell.run(file)