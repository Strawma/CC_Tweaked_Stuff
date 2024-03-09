local interrupted
function read()
    interrupted = false
    local output = ""
    while not interrupted do
        local event, key = os.pullEvent()
        if event == "char" then
            output = output .. key
            print (output)
        elseif event == "key" then
            if key == keys.enter then
                return output
            elseif key == keys.backspace then
                output = string.sub(output, 1, -2)
                print (output)
            end
        end
    end
    return nil
end

function interrupt()
    interrupted = true
end