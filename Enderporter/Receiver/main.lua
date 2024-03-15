os.loadAPI("strawma_api.lua")
local MODEM = peripheral.find("modem")
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
            rs.setOutput("back", true)
            rs.setOutput("down", true)
            sleep(1)
            rs.setOutput("back", false)
            rs.setOutput("down", false)
        end
    end
end