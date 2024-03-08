-- Grab using
-- wget https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/startup.lua

local file = "main.lua"

local apiUrl = "https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/strawma_api.lua"
local apiFile = "strawma_api.lua"

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

download(apiUrl, apiFile)
os.loadAPI(apiFile)

local function setProtocol()
    local fileName = "Protocol.txt"
    strawma_api.tryReadWriteFile(fileName, "Enter protocol: ")
end

setProtocol()

local function getUrl() 
    local fileName = "MAINURL.txt"
    return strawma_api.tryReadWriteFile(fileName, "Enter main.lua url: ")
end

local url = getUrl()
download(url, file)
shell.run(file)