os.loadAPI("strawma_api.lua")
local NETWORK = strawma_api.getNetwork()
local CHANNEL = strawma_api.networkToChannel(NETWORK)

local availableLocations

local modem = peripheral.find("modem")
modem.open(CHANNEL)

local function constructLocations(found)
    if #found == 0 then
        return "No locations found"
    else
        local msg = "Locations found:"
        for i, name in ipairs(found) do
            msg = msg .. "\n" .. i .. ": " .. name
        end
        return msg
    end
end

local function displayText()
    strawma_api.refresh()
    print(availableLocations .. "\n")
    write("Enter a location: ")
end

local function discoverRequest()
    local timerID = os.startTimer(3) 
    local found = {}
    modem.transmit(CHANNEL, CHANNEL, {"discover", nil})
    while true do
        local eventData = {os.pullEvent()}
        if eventData[1] == "timer" and eventData[2] == timerID then
            break
        elseif eventData[1] == "modem_message" then
            local event, side, channel, replyChannel, message, distance = table.unpack(eventData)
            if channel == CHANNEL and message[1] == "discovery_response" then
                table.insert(found, message[2])
            end
        end
    end
    local temp = constructLocations(found)
    if temp ~= availableLocations then
        availableLocations = temp
        displayText()
    end
end

local function takeInput()
    while true do
        displayText()
        local location = read()
        if location ~= nil then
            modem.transmit(CHANNEL, CHANNEL, {"tp", location})
        end
        sleep(0.1)
    end
end

local function run()
    strawma_api.refresh()
    print "Searching for locations..."
    discoverRequest()
    takeInput()
end

run()