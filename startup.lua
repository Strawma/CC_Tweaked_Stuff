local mainFile = "main.lua"

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
    local fileName = "PROTOCOL.txt"
    strawma_api.tryReadWriteFile(fileName, "Enter protocol: ")
end

setProtocol()

local function getMainUrl()
    local fileName = "MAIN_URL.txt"
    local url = strawma_api.tryReadFile(fileName)
    if url == nil then
        url = arg[1]
    end
end

local mainUrl = getMainUrl()
download(mainUrl, mainFile)
shell.run(mainFile)
