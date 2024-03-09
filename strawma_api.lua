function getProtocol()
    local fileName = "PROTOCOL.txt"
    local file = fs.open(fileName, "r")
    local protocol = file.readLine()
    file.close()
    return protocol
end

function tryReadFile(fileName)
    local content
    if fs.exists(fileName) then
        local file = fs.open(fileName, "r")
        content = file.readAll()
        file.close()
        return content
    end
    return nil
end

function writeFile(fileName, content)
    local file = fs.open(fileName, "w")
    file.write(content)
    file.close()
end

function tryReadWriteFile(fileName, writePrompt)
    local content = tryReadFile(fileName)
    if content == nil then
        write(writePrompt)
        content = read()
        writeFile(fileName, content)
    end
    return content
end

function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

function ImportInterruptibleRead()
    local url = "https://raw.githubusercontent.com/Strawma/CC_Tweaked_Stuff/main/interruptible_read.lua"
    local fileName = "interruptible_read.lua"
    download(url, fileName)
    os.loadAPI(fileName)
end

function refresh()
    term.clear()
    term.setCursorPos(1, 1)
end