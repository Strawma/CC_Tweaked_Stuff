os.loadAPI("strawma_api.lua")

local PROTOCOL = strawma_api.getProtocol()
local MODEM = "back"

rednet.open(MODEM)

local function teleportRequest(location)
    rednet.broadcast("tp", PROTOCOL .. location)
end

local function discoverRequest()
    print("Discovering locations...")
    local timeout = 3
    local found = {}
    rednet.broadcast("discover", PROTOCOL)
    while os.clock() < timeout do
        local id, name, protocol = rednet.receive(timeout - os.clock())
        if protocol == PROTOCOL .. "discovery_response" then
            table.insert(found, name)
        end
    end
    strawma_api.refresh()
    if #found == 0 then
        print("No locations found")
    else
        print("Locations found:")
        for i, name in ipairs(found) do
            print(i .. ": " .. name)
        end
    end
    print()
end

while true do
    strawma_api.refresh()

    discoverRequest()

    write("Enter a location: ")
    local location = read()
    if location == "exit" then
        break
    end
    teleportRequest(location)
end