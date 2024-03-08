os.loadAPI("strawma_api.lua")
local PROTOCOL = strawma_api.getProtocol()
local MODEM = "back"

rednet.open(MODEM)

local function teleportRequest(location)
    rednet.broadcast("tp", PROTOCOL .. location)
end

local function discoverRequest()
    strawma_api.refresh()
    print("Discovering locations...")
    local timerID = os.startTimer(5)
    local found = {}
    rednet.broadcast("discover", PROTOCOL)
    while true do
        local id, name, protocol = rednet.receive()
        if protocol == PROTOCOL .. "discovery_response" then
            table.insert(found, name)
        end
        local event, id = os.pullEvent("timer")
        if id == timerID then
            break
        end
    end
    if #found == 0 then
        return "No locations found"
    else
        msg = "Locations found:"
        for i, name in ipairs(found) do
            msg = msg .. "\n" .. i .. ": " .. name
        end
    end
    return msg
end

local displayMsg = discoverRequest()
while true do
    strawma_api.refresh()
    print(displayMsg)

    write("Enter a location: ")
    local location = read()
    if location == "exit" then
        break
    end
    teleportRequest(location)
end