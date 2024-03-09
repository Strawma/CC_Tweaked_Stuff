os.loadAPI("strawma_api.lua")
local PROTOCOL = strawma_api.getProtocol()
local MODEM = "back"

local availableLocations = "Searching for locations..."

rednet.open(MODEM)

local function teleportRequest(location)
    rednet.broadcast("tp", PROTOCOL .. location)
end

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

local function discoverRequest()
    while true do
        local timerID = os.startTimer(10) 
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
        availableLocations = constructLocations(found)
    end
end

local function run()
    while true do
        strawma_api.refresh()
        print(availableLocations .. "\n")
    
        write("Enter a location: ")
        local location = read()

        teleportRequest(location)
    end
end

local function runInParallel()
    parallel.waitForAny(discoverRequest, run)
end

runInParallel()