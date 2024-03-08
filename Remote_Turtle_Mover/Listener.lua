rednet.open("back")
local TURTLE_ID = 1

function sendCmd(cmd)
        rednet.send(TURTLE_ID, cmd)
end

while true do
    write("Enter command: ")
    local cmd = read()
    if cmd == "exit" then
        break
    end
    sendCmd(cmd)
end
