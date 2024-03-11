os.loadAPI("strawma_api.lua")

local function refuel()
    if turtle.getFuelLevel() < 10 then
        strawma_api.refresh()
        print("Refueling...")
        local hasFuel = strawma_api.switchToItem("minecraft:coal")
        if not hasFuel then
            print("No fuel found")
            while not hasFuel do
                strawma_api.refresh()
                hasFuel = strawma_api.switchToItem("minecraft:coal")
                sleep(5)
            end
            print("Fuel found")
        end
        turtle.refuel()
    end
end

local function checkForAnvil()
    local success = strawma_api.switchToItem("minecraft:anvil")
    if not success then
        strawma_api.refresh()
        print("Anvil not found")
        while not success do
            success = strawma_api.switchToItem("minecraft:anvil")
            sleep(5)
        end
        print("Anvil found")
    end

end

local function takeFromRightChest()
    local chest = peripheral.wrap("right")
    local items = chest.list()
    local tookItem = false
    local itemSlot = strawma_api.switchToEmptySlot()
    print("Searching for item")
    while not tookItem do
        for slot, item in pairs(items) do
            tookItem = chest.pushItems("left", slot, 1)
        end
    end
    print("Item taken")
    return itemSlot
end

local function crushItem()
    turtle.up()
    turtle.drop()
    turtle.up()
    strawma_api.switchToItem("minecraft:anvil")
    turtle.placeDown()
    turtle.down()
    turtle.suckDown()
    turtle.digDown()
    turtle.suckDown()
    turtle.down()
end

local function pushToLeftChest()
    local chest = peripheral.wrap("left")
    local items = chest.list()
    local pushedItem = false
    while not pushedItem do
        for slot, item in pairs(items) do
            pushedItem = chest.pullItems("right", slot, 1)
        end
    end
    print("Item pushed")
end

local function run()
    while true do
        refuel()
        checkForAnvil()
        takeFromRightChest()
        crushItem()
        pushToLeftChest()
    end
end

run()