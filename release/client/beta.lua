rednet.open(peripheral.getName(peripheral.find("modem")))
local var = {
    user = nil,
    userR,
    userW,
    vers = "3.2.4.2",
    run = true,
    mainServer = 41
}
local path = {
    user = "user.txt",
    latVers = "versionLatest.txt"
}
local link = {
    vers = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/client/version.txt",
    update = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/client/beta.lua"
}
local commands = {
    ["help"] = function() io.write("Available commands: help | version | change user | clear | update | exit | craft | server | gate | e1 | e2 | e3 | e4 | fuel\n") end,
    ["version"] = function() io.write("Current running version: " .. var.vers .. "\n") end,
    ["change user"] = function()
        if not fs.exists(path.user) then
            local file = fs.open(path.user, "w")
            file.write("root")
            file.close()
        end
        local file = fs.open(path.user, "w")
        io.write("Enter new user: ")
        local input = read()
        file.write(input)
        file.close()
        file = fs.open(path.user, "r")
        var.user = file.readLine()
        file.close()
        return true
    end,
    ["clear"] = function()
        shell.run("clear")
        return true
    end,
    ["update"] = function(args)
        local force = false
        local yes = false
        for _, arg in ipairs(args) do
            if arg == "-f" then force = true
            elseif arg == "-y" then yes = true
            else
                term.setTextColor(colors.red)
                print("Unknown option: " .. arg)
                term.setTextColor(colors.white)
                return false
            end
        end
        io.write("Checking for updates...")
        local suc, err = shell.run("wget " .. link.vers .. " " .. path.latVers)
        if not suc then
            term.setTextColor(colors.red)
            print("Failed to fetch version info ", tostring(err))
            term.setTextColor(colors.white)
            return false
        end
        if fs.exists(path.latVers) then
            local file = fs.open(path.latVers, "r")
            if file then
                local latVers = file.readLine()
                file.close()
                fs.delete(path.latVers)
                latVers = latVers:match("^%s*(.-)%s*$")
                var.vers = var.vers:match("^%s*(.-)%s*$")
                if latVers ~= var.vers then
                    io.write("Latest version available: " .. latVers .. ".\nCurrent version: " .. var.vers .. "\n")
                    if force then
                        term.setTextColor(colors.red)
                        io.write("Force updating...\n")
                        term.setTextColor(colors.white)
                        shell.run("rm startup")
                        local suc, err = shell.run("wget " .. link.update .. " startup")
                        if suc then
                            term.setTextColor(colors.green)
                            io.write("Updated to version " .. latVers .. "\n")
                            term.setTextColor(colors.yellow)
                            io.write("Rebooting in 2s...")
                            term.setTextColor(colors.white)
                            sleep(2)
                            os.reboot()
                        else
                            term.setTextColor(colors.red)
                            io.write("Failed to update script: ", tostring(err) .. "\n")
                            term.setTextColor(colors.white)
                            return false
                        end
                    elseif yes then
                        term.setTextColor(colors.green)
                        io.write("Do you want to proceed with the update? (y/n): ")
                        io.write("Updating...\n")
                        term.setTextColor(colors.white)
                        shell.run("rm startup")
                        local suc, err = shell.run("wget " .. link.update .. " startup")
                        if suc then
                            term.setTextColor(colors.green)
                            io.write("Updated to version " .. latVers .. "\n")
                            term.setTextColor(colors.yellow)
                            io.write("Rebooting in 2s...")
                            term.setTextColor(colors.white)
                            sleep(2)
                            os.reboot()
                        else
                            term.setTextColor(colors.red)
                            io.write("Failed to update script: ", tostring(err) .. "\n")
                            term.setTextColor(colors.white)
                            return false
                        end
                    else
                        term.setTextColor(colors.green)
                        io.write("Do you want to proceed with the update? (y/n): ")
                        term.setTextColor(colors.white)
                        local proceed = read()
                        io.write("\n")
                        if proceed:lower() == "y" then
                            term.setTextColor(colors.green)
                            io.write("Updating...\n")
                            term.setTextColor(colors.white)
                            shell.run("rm startup")
                            local suc, err = shell.run("wget " .. link.update .. " startup")
                            if suc then
                                term.setTextColor(colors.green)
                                io.write("Updated to version " .. latVers .. "\n")
                                term.setTextColor(colors.yellow)
                                io.write("Rebooting in 2s...")
                                term.setTextColor(colors.white)
                                sleep(2)
                                os.reboot()
                            else
                                term.setTextColor(colors.red)
                                io.write("Failed to update script: ", tostring(err) .. "\n")
                                term.setTextColor(colors.white)
                                return false
                            end
                        else
                            term.setTextColor(colors.red)
                            io.write("Update aborted.\n")
                            term.setTextColor(colors.white)
                            return false
                        end
                    end
                else
                    term.setTextColor(colors.green)
                    io.write("No current updates available.\n")
                    term.setTextColor(colors.white)
                    return true
                end
            else
                term.setTextColor(colors.red)
                io.write("Failed to read file.\n")
                term.setTextColor(colors.white)
                return false
            end
        end
    end,
    ["exit"] = function()
        term.setTextColor(colors.yellow)
        io.write(var.user .. "@:~$ Goodbye!\n")
        term.setTextColor(colors.white)
        sleep(1.3)
        shell.run("clear")
        var.run = false
        return true
    end,
    ["craft"] = function()
        rednet.send(var.mainServer, {command = "craft", args = {}})
        cmdRes()
        return true
    end,
    ["server"] = function()
        rednet.send(var.mainServer, {command = "server", args = {}})
        cmdRes()
        return true
    end,
    ["gate"] = function()
        rednet.send(var.mainServer, {command = "gate", args = {}})
        cmdRes()
        return true
    end,
    ["e1"] = function()
        rednet.send(var.mainServer, {command = "e1", args = {}})
        cmdRes()
        return true
    end,
    ["e2"] = function()
        rednet.send(var.mainServer, {command = "e2", args = {}})
        cmdRes()
        return true
    end,
    ["e3"] = function()
        rednet.send(var.mainServer, {command = "e3", args = {}})
        cmdRes()
        return true
    end,
    ["e4"] = function()
        rednet.send(var.mainServer, {command = "e4", args = {}})
        cmdRes()
        return true
    end,
    ["fuel"] = function(args)
        rednet.send(var.mainServer, {command = "fuel", args = args})
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        local ID, packet = rednet.receive()
        if ID == var.mainServer then
            local total = math.floor(packet)
            local h = math.floor(total / 3600)
            local m = math.floor((total % 3600) / 60)
            local s = total % 60
            io.write(string.format(
                "[Fuel] Time left: %02d:%02d:%02d\n",
                h,
                m,
                s
            ))
        end
        return true
    end
}
local function cmdRes()
    term.setTextColor(colors.green)
    io.write(var.user .. "@:~$ Command sent!")
    term.setTextColor(colors.white)
end
local function checkFiles()
    local complete = true
    if not fs.exists("scripts/") then shell.run("mkdir scripts/") end
    while complete do
        if not fs.exists("scripts/client.lua") then shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/client/beta.lua scripts/client.lua") end
        if not fs.exists("scripts/rukeiSubServer.lua") then shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/server/subserver/rednetReceiver.lua scripts/rukeiSubServer.lua") end
        complete = false
    end
    if not fs.exists(path.user) then
        local file = fs.open(path.user, "w")
        file.write("root")
        file.close()
    end
    local file = fs.open(path.user, "r")
    var.user = file.readLine()
    file.close()
end
local function parseCommand(input)
    local args = {}
    for word in string.gmatch(input, "%S+") do table.insert(args, word) end
    local command = table.remove(args, 1)
    return command, args
end
local function()
    local ID, packet = rednet.receive()
    if type(packet) == table and packet.action == "fetch" then
        local file = packet.script
        if fs.exists("scripts/" .. file) and not fs.isDir(file) then
            local localFile = io.open(file, "r")
            local content = localFile:read("*a")
            localFile:close()
            rednet.send(ID, content)
            io.write(var.user .. "@:~$ " .. file .. " downloaded to " .. ID .. "\n")
        else
            rednet.send(ID, "Error: File can't be processed")
        end
    end
end
checkFiles()
io.write("Version: " .. var.vers .. "\n")
while var.run do
    io.write(var.user .. "@:~$ ")
    local input = read()
    local parts = {}
    for command in string.gmatch(input, "[^&]+") do table.insert(parts, command) end
    local success = true
    for _, commandInput in ipairs(parts) do
        commandInput = commandInput:gsub("^%s+", ""):gsub("%s+$", "")
        if success and var.run then
            local command, args = parseCommand(commandInput)
            if commands[command] then
                success = commands[command](args)
                if success == nil then success = true end
            else
                term.setTextColor(colors.red)
                io.write("Unknown command: " .. command .. "\n")
                term.setTextColor(colors.white)
                success = false
            end
        end
    end
end