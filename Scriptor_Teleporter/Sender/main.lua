os.loadAPI("strawma_api.lua")
local PROTOCOL = strawma_api.getProtocol()
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
    while true do
        local timerID = os.startTimer(5) 
        local found = {}
        rednet.broadcast("discover", PROTOCOL)
        while true do
            local event, id, name, protocol = os.pullEvent()
            if event == "timer" and id == timerID then
                break
            elseif event == "rednet_message" and protocol == PROTOCOL .. "discovery_response" then
                table.insert(found, name)
            end
        end
        local temp = constructLocations(found)
        if temp ~= availableLocations then
            availableLocations = temp
            displayText()
        end
    end
end

local function takeInput()
    while true do
        local location = read()
        rednet.broadcast("tp", PROTOCOL .. location)
    end
end

local function run()
    print "Searching for locations..."
    discoverRequest()
    parallel.waitForAny(discoverRequest, takeInput)
end

run()