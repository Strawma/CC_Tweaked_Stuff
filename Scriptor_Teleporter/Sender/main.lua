os.loadAPI("strawma_api.lua")
local NETWORK = strawma_api.getNetwork()
local MODEM = "back"

local availableLocations

rednet.open(MODEM)

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
    rednet.broadcast("discover", NETWORK)
    while true do
        local event, id, name, network = os.pullEvent()
        if event == "timer" and id == timerID then
            break
        elseif event == "rednet_message" and network == NETWORK .. "discovery_response" then
            table.insert(found, name)
        end
    end
    local temp = constructLocations(found)
    if temp ~= availableLocations then
        availableLocations = temp
        displayText()
    end
end

local function keepDiscovering()
    while true do
        discoverRequest()
        sleep(10)
    end
end

local function takeInput()
    while true do
        displayText()
        local location = read()
        if location ~= nil then
            rednet.broadcast("tp", NETWORK .. location)
        end
    end
end

local function run()
    strawma_api.refresh()
    print "Searching for locations..."
    discoverRequest()
    parallel.waitForAny(keepDiscovering, takeInput)
end

run()
