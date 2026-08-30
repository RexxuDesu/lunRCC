rednet.open("back")
local user
local run = true
local path = {
    userR = fs.open("user.txt", "r"),
    userW = fs.open("user.txt", "w")
}
local commands = {
    ["change user"] = function()
        if user ~= nil and user:gsub("%s", "") ~= "" then
            term.setTextColor(colors.white)
            io.write(user .. "@:~$ Enter new username: ")
            local temp = read()
            path.userW.write(temp)
            path.userW.close()
            user = path.userR.readLine()
        end
    end,
    ["clear"] = function()
        shell.run("clear")
    end,
    ["exit"] = function()
        term.setTextColor(colors.yellow)
        io.write(user .. "@:~$ Goodbye!")
        term.setTextColor(colors.white)
        sleep(1.3)
        shell.run("clear")
        run = false
    end,
    ["inv"] = function()
        rednet.send(61, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["craft"] = function()
        rednet.send(60, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["server"] = function()
        rednet.send(42, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e1"] = function()
        rednet.send(65, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e2"] = function()
        rednet.send(64, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e3"] = function()
        rednet.send(63, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e4"] = function()
        rednet.send(62, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end
}
if fs.exists("user.txt") then
    user = path.userR.readLine()
    path.userR.close()
    if user == nil or user:gsub("%s", "") == "" then
        path.userW.write("root")
        path.userW.close()
        user = path.userR.readLine()
        path.userR.close()
    else
        user = path.userR.readLine()
        path.userR.close()
    end
end

local function update()

end
while run do
    io.write(user .. "@:~$ ")
    local input = read()
    if commands[input] then
        commands[input]()
    else
        term.setTextColor(colors.red)
        io.write("Unknown command: " .. input)
        term.setTextColor(colors.white)
    end
end