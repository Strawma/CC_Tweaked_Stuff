function getChannel()
    local fileName = "CHANNEL.txt"
    local file = fs.open(fileName, "r")
    local channel = file.readLine()
    file.close()
    return channel
end

function tryReadWriteFile(fileName, writePrompt)
    local content
    if fs.exists(fileName) then
        local file = fs.open(fileName, "r")
        content = file.readAll()
        file.close()
    else
        local file = fs.open(fileName, "w")
        write(writePrompt)
        content = read()
        file.write(content)
        file.close()
    end
    return content
end