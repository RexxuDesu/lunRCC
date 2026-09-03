rednet.open(peripheral.getName(peripheral.find("modem")))
local var = {
    user = nil,
    userR,
    userW,
    vers = "3.2.2.4",
    run = true
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
            if arg == "-f" then
                force = true
            elseif arg == "-y" then
                yes = true
            else
                term.setTextColor(colors.red)
                print("Unknown option: " .. arg)
                term.setTextColor(colors.white)
                return false
            end
        end
        if force then
            term.setTextColor(colors.green)
            io.write("Force updating...\n")
            term.setTextColor(colors.white)
            shell.run("rm startup")
            local suc, err = shell.run("wget " .. link.update .. " startup")
            if suc then
                term.setTextColor(colors.yellow)
                io.write("Rebooting in 2s...")
                term.setTextColor(colors.white)
                sleep(2)
                os.reboot()
            else
                term.setTextColor(colors.red)
                io.write("Failed to update script: ", err .. "\n")
                term.setTextColor(colors.white)
                return false
            end
        else
            io.write("Checking for updates...")
            local suc, err = shell.run("wget " .. link.vers .. " " .. path.latVers)
            if not suc then
                term.setTextColor(colors.red)
                print("Failed to fetch version info ", err)
                term.setTextColor(colors.white)
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
                        term.setTextColor(colors.green)
                        io.write("Do you want to proceed with the update? (y/n): ")
                        term.setTextColor(colors.white)
                        local proceed = read()
                        io.write("\n")
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
                            io.write("Failed to update script: ", err .. "\n")
                            term.setTextColor(colors.white)
                            return false
                        end
                        term.setTextColor(colors.red)
                        io.write("Update aborted.\n")
                        term.setTextColor(colors.white)
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
        end
        if not yes then
            io.write("Checking for updates...")
            local suc, err = shell.run("wget " .. link.vers .. " " .. path.latVers)
            if not suc then
                term.setTextColor(colors.red)
                print("Failed to fetch version info ", err)
                term.setTextColor(colors.white)
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
                                io.write("Failed to update script: ", err .. "\n")
                                term.setTextColor(colors.white)
                                return false
                            end
                        else
                            term.setTextColor(colors.red)
                            io.write("Update aborted.\n")
                            term.setTextColor(colors.white)
                            return false
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
        rednet.send(60, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["server"] = function()
        rednet.send(42, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["gate"] = function()
        rednet.send(66, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["e1"] = function()
        rednet.send(65, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["e2"] = function()
        rednet.send(64, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["e3"] = function()
        rednet.send(63, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["e4"] = function()
        rednet.send(62, "1")
        term.setTextColor(colors.green)
        io.write(var.user .. "@:~$ Command sent!")
        term.setTextColor(colors.white)
        return true
    end,
    ["fuel"] = function(args)
        local give = false
        local status = false
        for _, arg in ipairs(args) do
            if arg == "-g" then
                give = true
            elseif arg == "-s" then
                status = true
            else
                term.setTextColor(colors.red)
                io.write("Unknown option: " .. arg)
                term.setTextColor(colors.white)
                return false
            end
        end
        if give then
            rednet.send(78, "give")
        elseif status then
            rednet.send(78, "status")
            local ID, packet = rednet.receive()
            if ID == 78 then
                local total = math.floor(packet)
                local h = math.floor(total / 3600)
                local m = math.floor((total % 3600) / 60)
                local s = total % 60
                local time = os.epoch("utc")
                local timeEnd = time + (total * 1000)
                io.write(string.format(
                    "[Fuel] Time left: %02d:%02d:%02d\n",
                    h,
                    m,
                    s
                ))
                local endSec = math.floor(timeEnd / 1000)
                local date = os.date("*t", endSec)
                io.write(string.format(
                    "[Fuel] Runs out at: %02d:%02d:%02d\n",
                    date.hour,
                    date.min,
                    date.sec
                ))
            end
        else
            term.setTextColor(colors.red)
            io.write("Syntax cannot be empty.\n")
            io.write("usage: fuel -g | -s\n")
            io.write("usage: -g | gives 64 nuclear fuel to the reactor\n")
            io.write("usage: -s | checks nuclear fuel time remainder\n")
            term.setTextColor(colors.white)
        end
    end
}
local function checkFiles()
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
    for word in string.gmatch(input, "%S+") do
        table.insert(args, word)
    end
    local command = table.remove(args, 1)
    return command, args
end
checkFiles()
io.write("Version: " .. var.vers .. "\n")
while var.run do
    io.write(var.user .. "@:~$ ")
    local input = read()
    local parts = {}
    for command in string.gmatch(input, "[^&]+") do
        table.insert(parts, command)
    end
    local success = true
    for _, commandInput in ipairs(parts) do
        commandInput = commandInput:gsub("^%s+", ""):gsub("%s+$", "")
        if success and var.run then
            local command, args = parseCommand(commandInput)
            if commands[command] then
                success = commands[command](args)
                if success == nil then
                    success = true
                end
            else
                term.setTextColor(colors.red)
                io.write("Unknown command: " .. command .. "\n")
                term.setTextColor(colors.white)
                success = false
            end
        end
    end
end