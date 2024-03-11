os.loadAPI("strawma_api.lua")
local FUEL_SLOT = 1
local ANVIL_SLOT = 2
local INPUT_SLOT = 3
local OUTPUT_SLOT = 4
local ANVIL = "minecraft:anvil"

local function needsFuel()
    return turtle.getFuelLevel() > 10
end

local function refuel()
    if needsFuel() then
        print("Refueling...")
        turtle.select(FUEL_SLOT)
        turtle.refuel()
        while needsFuel() do
            print("please add fuel to slot 1")
            while not turtle.refuel() do
                sleep(10)
            end
            print("Fuel found")
        end
    end
end

local function hasAnvil()
    return strawma_api.checkForItem(ANVIL, ANVIL_SLOT)
end

local function checkForAnvil()
    turtle.select(ANVIL_SLOT)
    if not hasAnvil() then
        print("Anvil not found, please add an anvil to slot 2")
        while not hasAnvil() do
            sleep(10)
        end
        print("Anvil found")
    end

end

local function hasInputItem()
    return turtle.getItemCount(INPUT_SLOT) > 0
end

local function takeFromRightChest()
    turtle.turnRight()
    turtle.select(INPUT_SLOT)
    turtle.suck()
    print("Searching for item")
    if not hasInputItem() then
        print("No item found in input chest")
        while not hasInputItem() do
            sleep(10)
            turtle.suck()
        end
    end
    print("Item taken")
    turtle.turnLeft()
    return itemSlot
end

local function crushItem()
    turtle.up()
    turtle.select(INPUT_SLOT)
    turtle.drop()
    turtle.up()
    turtle.select(ANVIL_SLOT)
    turtle.placeDown()
    turtle.down()
    turtle.select(OUTPUT_SLOT)
    turtle.suckDown()
    turtle.digDown()
    turtle.select(ANVIL_SLOT)
    turtle.suckDown()
    turtle.down()
end

local function hasOutputItem()
    return turtle.getItemCount(OUTPUT_SLOT) > 0
end

local function pushToLeftChest()
    turtle.turnLeft()
    turtle.select(OUTPUT_SLOT)
    turtle.drop()
    if hasOutputItem() then
        print("Item not pushed to chest")
        while hasOutputItem() do
            sleep(10)
            turtle.drop()
        end
    end
    print("Item pushed to chest")
    turtle.turnRight()
end

local function run()
    while true do
        strawma_api.refresh()
        refuel()
        checkForAnvil()
        takeFromRightChest()
        crushItem()
        pushToLeftChest()
    end
end

run()