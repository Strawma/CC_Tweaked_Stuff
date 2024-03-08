rednet.open("right")
while true do
    local id, cmd = rednet.receive()
    print("Received command: " .. cmd)
    if cmd == "forward" then
        turtle.forward()
    elseif cmd == "drop" then
        turtle.select(16)
        turtle.dropDown()
        turtle.suckDown()
        turtle.select(1)
    end
    turtle.refuel()
    print ("Current fuel level: " .. turtle.getFuelLevel())
end