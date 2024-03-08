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