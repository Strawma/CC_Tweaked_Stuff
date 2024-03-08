rednet.open("right")
while true do
    local id, cmd = rednet.receive()
    print("Received command: " .. cmd)
    if cmd == "forward" then
        turtle.forward()
    end
    turtle.refuel()
    print ("Current fuel level: " .. turtle.getFuelLevel())
end