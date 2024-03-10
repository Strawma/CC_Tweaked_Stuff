function getProtocol()
    local fileName = "PROTOCOL.txt"
    local file = fs.open(fileName, "r")
    local protocol = file.readLine()
    file.close()
    return protocol
end

function readInput()
    local input = ""
    while true do
        local event, key = os.pullEvent()
        if event == "char" then
            input = input .. key
            write(key)
        elseif event == "key" then
            if key == keys.enter then
                return input
            elseif key == keys.backspace and input:len() > 0 then
                input = input:sub(1, -2)
                local x, y = term.getCursorPos()
                term.setCursorPos(x - 1, y)
                write("")
            end
        end
    end
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
        content = readInput()
        writeFile(fileName, content)
    end
    return content
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