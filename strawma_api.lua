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

function getNetwork()
    return tryReadFile("NETWORK.txt")
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

function tryReadCreateFile(fileName, defaultContent) 
    local content = tryReadFile(fileName)
    if content == nil then
        writeFile(fileName, defaultContent)
    end
end

function download(url, filePath)
    if not fs.exists(filePath) then
        fs.makeDir(filePath)
    end
    local response = http.get(url)
    if not response then
        error("Failed to download file: " .. url)
    end
    local content = response.readAll()
    response.close()
    if fs.exists(filePath) then
        fs.delete(filePath)
    end
    local file = fs.open(filePath, "w")
    file.write(content)
    file.close()
    print("Downloaded", url, "to", filePath)
end

function refresh()
    term.clear()
    term.setCursorPos(1, 1)
end

function findItem(name)
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name == name then
            return slot
        end
    end
    return nil
end