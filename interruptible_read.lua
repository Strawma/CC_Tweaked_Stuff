local interrupted
function read()
    interrupted = false
    local output = ""
    while not interrupted do
        local event, key = os.pullEvent("key")
        if event == "char" then
            if key == "\n" then
                return output
            elseif key == "\b" then
                output = string.sub(output, 1, -2)
            else
                output = output .. key
            end
        end
    end
    return nil
end

function interrupt()
    interrupted = true
end