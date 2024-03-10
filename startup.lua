local tempPullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw
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
updateSelf()

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

local apiUrl = "https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/strawma_api.lua"
local apiFile = "strawma_api.lua"
download(apiUrl, apiFile)
os.loadAPI(apiFile)

local password
local function pullEventSecure()
    local event = {os.pullEvent()}
    if event[1] == "terminate" then
        print("Enter your password to terminate: ")
        local input = read("*")
        if input ~= password then
            print("Incorrect password. Shutting down in 3 seconds...")
            sleep(3)
            os.shutdown()
        end
        os.pullEvent = tempPullEvent
        os.queueEvent("terminate")
    end
    return table.unpack(event)
end

local function applySecurity()
    local security = strawma_api.tryReadFile("SECURITY.txt")
    if security == nil then
        while true do
            print("Enable security? (y/n): ")
            security = read()
            if security == "y" then
                strawma_api.writeFile("SECURITY.txt", "y")
                break
            elseif security == "n" then
                strawma_api.writeFile("SECURITY.txt", "n")
                break
            end
        end
    elseif security == "y" then
        password = strawma_api.tryReadWriteFile("PASSWORD.txt", "Create a password: ")
        os.pullEvent = pullEventSecure
    else
        os.pullEvent = tempPullEvent
    end
end
applySecurity()


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
        strawma_api.writeFile(fileName, url)
    end
    return url
end

local mainFile = "main.lua"
local mainUrl = getMainUrl()
download(mainUrl, mainFile)
shell.run(mainFile)
