rednet.open(peripheral.getName(peripheral.find("modem")))
local var = {
    user = nil,
    userR,
    userW,
    vers = "3.2.1.3",
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
    ["update"] = function()
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
    end,
    ["update -f"] = function()
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
checkFiles()
while var.run do
    io.write(var.user .. "@:~$ ")
    local input = read()
    local parts = {}
    for command in string.gmatch(input, "[^&]+") do
        table.insert(parts, command)
    end
    local suc = true
    for _, command in ipairs(parts) do
        command = command:gsub("^%s+", ""):gsub("%s+$", "")
        if suc then
            if commands[command] then
                suc = commands[command]()
            else
                term.setTextColor(colors.red)
                io.write("Unknown command: " .. command .. "\n")
                term.setTextColor(colors.white)
                suc = false
            end
        end
    end
end