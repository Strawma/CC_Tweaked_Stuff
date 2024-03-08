os.loadAPI("strawma_api.lua")
local MODEM = "right"
local PROTOCOL = strawma_api.getProtocol()
local NAME = strawma_api.tryReadWriteFile("NAME.txt", "Enter location name: ")

rednet.open(MODEM)
while true do
    local id, cmd, location = rednet.receive()
    if location == PROTOCOL and cmd == "discover" then
        print("Received discover request")
        rednet.send(id, NAME, PROTOCOL .. "discovery_response")
    elseif location == PROTOCOL .. NAME then
        print("Received command: " .. cmd)
        if cmd == "tp" then
            turtle.select(16)
            turtle.dig()
            turtle.suck()
            turtle.dropUp()
            turtle.select(1)
        end
    end
end