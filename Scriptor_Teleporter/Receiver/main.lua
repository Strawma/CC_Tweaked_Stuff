os.loadAPI("strawma_api.lua")
local MODEM = "right"
local NETWORK = strawma_api.getNetwork()
local NAME = strawma_api.tryReadWriteFile("NAME.txt", "Enter location name: ")
local LOCATION = NETWORK .. NAME

rednet.open(MODEM)
while true do
    local id, cmd, network = rednet.receive()
    if network == NETWORK and cmd == "discover" then
        print("Received discover request")
        rednet.send(id, NAME, NETWORK .. "discovery_response")
    elseif network == LOCATION then
        print("Received command: " .. cmd)
        if cmd == "tp" then
            turtle.select(16)
            turtle.digDown()
            turtle.suckDown()
            turtle.dropUp()
            turtle.suckUp()
            turtle.select(1)
        end
    end
end
