rednet.open("back")
local user = fs.open("user.txt", "r").readLine()
local run = true
local commands = {
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
    ["m1"] = function()
        rednet.send(60, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["m2"] = function()
        rednet.send(42, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e1"] = function()
        rednet.send(62, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e2"] = function()
        rednet.send(63, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e3"] = function()
        rednet.send(64, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end,
    ["e4"] = function()
        rednet.send(65, "1")
        term.setTextColor(colors.green)
        io.write(user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
    end
}
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