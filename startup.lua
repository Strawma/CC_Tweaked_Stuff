local url = ""
local file = "exampleFile.lua"

local function download(url, file)
    if fs.exists(file) then
        fs.delete(file)
    end
    shell.run("wget", url, file)
end

download(url, file)
shell.run(file)