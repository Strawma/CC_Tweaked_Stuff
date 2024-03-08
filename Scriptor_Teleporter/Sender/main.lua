os.loadAPI("strawma_api.lua")

local PROTOCOL = strawma_api.getProtocol()
local MODEM = "back"

rednet.open(MODEM)

local function teleportRequest(location)
    rednet.broadcast("tp", PROTOCOL .. location)
end

local function discoverRequest()
    print("Discovering locations...")
    local timerID = os.startTimer(5)
    local found = {}
    rednet.broadcast("discover", PROTOCOL)
    while true do
        local id, name, protocol = rednet.receive(timeout - os.clock())
        local event, id = os.pullEvent()
        if id == timerID then
            break
        end
        if protocol == PROTOCOL .. "discovery_response" then
            table.insert(found, name)
        end
    end
    strawma_api.refresh()
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