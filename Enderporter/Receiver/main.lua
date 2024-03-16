os.loadAPI("strawma_api.lua")
local NETWORK = strawma_api.getNetwork()
local CHANNEL = strawma_api.networkToChannel(NETWORK)
local NAME = strawma_api.tryReadWriteFile("NAME.txt", "Enter location name: ")

local modem = peripheral.find("modem")
modem.open(CHANNEL)
rs.setOutput("back", true)
while true do
    local event, side, channel, replyChannel, message, distance
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == CHANNEL
    local cmd, location = table.unpack(message)
    if cmd == "discover" then
        modem.transmit(CHANNEL, CHANNEL, {"discovery_response", NAME})
    elseif cmd == "tp" and location == NAME then
        rs.setOutput("back", false)
        rs.setOutput("bottom", true)
        sleep(1)
        rs.setOutput("back", true)
        rs.setOutput("bottom", false)
    end
end