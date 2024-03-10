local security = true
local password = "test"

local function askForPassword()
    term.clear()
    term.setCursorPos(1, 1)
    write("Enter password: ")
    local input = read("*")
    if input == password then
        return true
    else
        return false
    end
end

local function securityOverride()
    while true do
        local event, key = os.pullEventRaw()
        if event == "terminate" then
            if security == false then
                break
            end
            if askForPassword() then
                break
            end
        end
    end
end

local function updateSelf()
    local tempFile = "temp.lua"
    local url = "https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/startup.lua"

    if fs.exists(tempFile) then
        fs.delete(tempFile)
    end

    local success = shell.run("wget", url, tempFile)

    if success then
        fs.delete("startup.lua")
        fs.move(tempFile, "startup.lua")
    else
        fs.delete(tempFile)
        print("Failed to update startup.lua")
    end
end

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

local function setProtocol()
    local fileName = "PROTOCOL.txt"
    strawma_api.tryReadWriteFile(fileName, "Enter protocol: ")
end

local function getMainUrl()
    local fileName = "MAIN_URL.txt"
    local url = strawma_api.tryReadFile(fileName)
    if url == nil then
        url = arg[1]
        strawma_api.writeFile(fileName, url)
    end
    return url
end

local function program()
    updateSelf()

    local mainFile = "main.lua"
    
    local apiUrl = "https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/strawma_api.lua"
    local apiFile = "strawma_api.lua"

    download(apiUrl, apiFile)
    os.loadAPI(apiFile)

    setProtocol()

    local mainUrl = getMainUrl()
    download(mainUrl, mainFile)
    shell.run(mainFile)
end

parallel.waitForAny(program, securityOverride)
