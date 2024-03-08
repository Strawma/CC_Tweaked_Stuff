os.loadAPI("strawma_api.lua")

local PROTOCOL = strawma_api.getProtocol()
local MODEM = "back"

rednet.open(MODEM)

local function teleportRequest(location)
    rednet.broadcast("tp", PROTOCOL .. location)
end

while true do
    term.clear()
    term.setCursorPos(1, 1)
    write("Enter a location: ")
    local location = read()
    if location == "exit" then
        break
    end
    teleportRequest(location)
end