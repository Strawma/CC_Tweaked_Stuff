os.loadAPI("strawma_api.lua")
local NETWORK = strawma_api.getNetwork()
local CHANNEL = strawma_api.networkToChannel(NETWORK)
local NAME = strawma_api.tryReadWriteFile("NAME.txt", "Enter location name: ")
local LOCATION = NETWORK .. NAME

local modem = peripheral.find("modem")
modem.open(CHANNEL)
while true do
    local event, side, channel, replyChannel, message, distance
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == CHANNEL
    local cmd, location = table.unpack(message)
    if cmd == "discover" then
        print("Received discover request")
        modem.transmit(CHANNEL, CHANNEL, {"discovery_response", NAME})
    elseif cmd == "tp" and location == NAME then
        print("Received command: " .. cmd)
        rs.setOutput("back", true)
        rs.setOutput("bottom", true)
        sleep(1)
        rs.setOutput("back", false)
        rs.setOutput("bottom", false)
    end
end