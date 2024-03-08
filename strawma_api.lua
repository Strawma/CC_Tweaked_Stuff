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

function tryReadWriteFile(fileName, writePrompt)
    local content = tryReadFile(fileName)
    if content == nil then
        local file = fs.open(fileName, "w")
        write(writePrompt)
        content = read()
        file.write(content)
        file.close()
    end
    return content
end