function getChannel()
    local fileName = "CHANNEL.txt"
    local file = fs.open(fileName, "r")
    local channel = file.readLine()
    file.close()
    return channel
end