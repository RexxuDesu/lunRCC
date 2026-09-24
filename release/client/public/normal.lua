if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local var = {
    user = nil,
    userR,
    userW,
    vers = "3.2.6.7",
    run = true,
    sts = false
}
local path = {
    user = "user.txt",
    latVers = "versionLatest.txt"
}
local link = {
    vers = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/client/public/version.txt",
    update = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/client/public/normal.lua"
}
local function cmdRes() -- DO NOT TOUCH
    term.setTextColor(colors.green)
    io.write(var.user .. "@:~/$ Command sent!")
    term.setTextColor(colors.white)
end
local function parseCommand(input) -- DO NOT TOUCH
    local args = {}
    for word in string.gmatch(input, "%S+") do table.insert(args, word) end
    local command = table.remove(args, 1)
    return command, args
end
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
local function clearKey()
    local timer = os.startTimer(0)
    while true do
        local event, param = os.pullEventRaw()
        if event == "timer" and param == timer then break end
    end
end
local function stasis()
    shell.run("clear")
    io.write("Press any of the keys below to pull your pearl:\n")
    io.write("  [t] Tethoris stasis.\n")
    io.write("  [v] Victoria stasis.\n")
    io.write("  [r] Rukei stasis.\n")
    io.write("  [c] Cancel.\n")
    while var.sts do
        local _, key = os.pullEvent("key")
        if key == keys.t then
            rednet.send(123, "1")
            var.sts = false
        elseif key == keys.v then
            rednet.send(127, "1")
            var.sts = false
        elseif key == keys.r then
            rednet.send(119, "1")
            var.sts = false
        elseif key == keys.c then
           var.sts = false 
        end
        clearKey()
        shell.run("clear")
        return true
    end
end
local commands = {
    ["help"] = function() io.write("Available commands: help | version | id | cuser | clear | cd | cp | mv | ls | nano | update | net | st\n") end,
    ["version"] = function(args) 
        if args[1] then
            if args[1] == "-h" then
                io.write("version\n")
                io.write("Prints the current installed version.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else io.write("Current running version: " .. var.vers .. "\n") end
    end,
    ["id"] = function(args) 
        if args[1] then
            if args[1] == "-h" then
                io.write("id\n")
                io.write("Prints this computer's ID.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else shell.run("id") end
    end,
    ["cuser"] = function(args)
        if not fs.exists(path.user) then
            local file = fs.open(path.user, "w")
            file.write("root")
            file.close()
        end
        local file = fs.open(path.user, "w")
        if args[1] then
            if args[1] == "-h" then
                io.write("cuser\n")
                io.write("Changes the displayed username.\n")
            else
                file.write(args[1])
                file.close()
                file = fs.open(path.user, "r")
                var.user = file.readLine()
            end
        else
            io.write("Enter new user: ")
            local input = read()
            if input and input ~= "" then
                file.write(input)
                file.close()
                file = fs.open(path.user, "r")
                var.user = file.readLine()
            else
                term.setTextColor(colors.red)
                io.write("Invalid entry detected.\n")
                term.setTextColor(colors.white)
            end
        end
        file.close()
    end,
    ["clear"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("clear\n")
                io.write("Clears/wipes the screen.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else 
            shell.run("clear")
            io.write("[LunROS version: " .. var.vers .. "]\n")
        end
    end,
    ["cd"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("cd\n")
                io.write("Changes the current directory, must need explaining?\n")
            else shell.run("cd " .. args[1]) end
        else 
            term.setTextColor(colors.red)
            io.write("Command requires a syntax.\n")
            term.setTextColor(colors.white)
        end
    end,
    ["cp"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("cp\n")
                io.write("Copies <syntax1> and saves as <syntax2>\n")
            elseif args[2] then shell.run("cp " .. args[1] .. " " .. args[2])
            else
                term.setTextColor(colors.red)
                io.write("Command requires syntax1 and syntax2.\n")
                term.setTextColor(colors.white)
            end
        else
            term.setTextColor(colors.red)
            io.write("Command requires a syntax.\n")
            term.setTextColor(colors.white)
        end
    end,
    ["mv"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("mv\n")
                io.write("Moves <syntax1> and saves as <syntax2>\n")
            elseif args[2] then shell.run("mv " .. args[1] .. " " .. args[2])
            else
                term.setTextColor(colors.red)
                io.write("Command requires syntax1 and syntax2.\n")
                term.setTextColor(colors.white)
            end
        else 
            term.setTextColor(colors.red)
            io.write("Command requires a syntax.\n")
            term.setTextColor(colors.white)
        end
    end,
    ["ls"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("ls\n")
                io.write("Lists the current directory's contents, must need explaining?\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else
            io.write(var.user .. "@:~$/" .. shell.dir() .. " \n")
            shell.run("ls")
        end
    end,
    ["nano"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("cd\n")
                io.write("Changes the current directory, must need explaining?\n")
            else shell.run("edit " .. args[1]) end
        else 
            term.setTextColor(colors.red)
            io.write("Command requires a syntax.\n")
            term.setTextColor(colors.white)
        end
    end,
    ["update"] = function(args)
        local force = false
        local yes = false
        if args[1] == "-h" then
            io.write("update\n")
            io.write("Updates the software.\n")
            io.write("Syntax:\n")
            io.write("-h | Displays command info.\n")
            io.write("-y | Appends yes to skip the (y/n) confirmation.\n")
            io.write("-f | Forces an update.\n")
            return true
        end
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
        if force then
            term.setTextColor(colors.red)
            io.write("Force updating...\n")
            term.setTextColor(colors.white)
            shell.run("rm startup")
            local suc, err = shell.run("wget " .. link.update .. " lunr")
            if suc then
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
                    if yes then
                        term.setTextColor(colors.green)
                        io.write("Do you want to proceed with the update? (y/n): ")
                        io.write("Updating...\n")
                        term.setTextColor(colors.white)
                        shell.run("rm startup")
                        local suc, err = shell.run("wget " .. link.update .. " lunr")
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
                            local suc, err = shell.run("wget " .. link.update .. " lunr")
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
    ["ex"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("ex\n")
                io.write("Terminates the program\n")
            else 
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)            
            end
        else 
            term.setTextColor(colors.yellow)
            io.write(var.user .. "@:~$ Goodbye!\n")
            term.setTextColor(colors.white)
            sleep(1)
            shell.run("clear")
            var.run = false
        end
    end,
    ["net"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("net\n")
                io.write("Simulates rednet.send.\n")
                io.write("Syntax:\n")
                io.write("-h | Displays command info.\n")
                io.write("-s <syntax1> <syntax2> | Sends a rednet.\n")
            elseif args[1] == "-s" then 
                if args[2] then 
                    rednet.send(tonumber(args[2]), args[3])
                    term.setTextColor(colors.green)
                    io.write(var.user .. "@:~/" .. shell.dir() .. "$ Packet sent!")
                    term.setTextColor(colors.white)
                else
                    term.setTextColor(colors.red)
                    io.write("Command requires syntax1 and syntax2.\n")
                    term.setTextColor(colors.white)
                end
            end
        else 
            term.setTextColor(colors.red)
            io.write("Command requires a syntax.\n")
            term.setTextColor(colors.white)
        end
    end,
    ["st"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("st\n")
                io.write("Activates a stasis chamber.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else
            var.sts = true
            stasis()
        end
    end
}
local function scriptFetch()
    while var.run do
        local ID, packet = rednet.receive()
        if type(packet) == "table" and packet.action == "fetch" then
            term.setTextColor(colors.yellow)
            io.write("\n[LunROS] Client " .. ID .. " requesting download for file: " .. packet.script .. ".\n")
            term.setTextColor(colors.white)
            io.write(var.user .. "@:~/" .. shell.dir() .. "$ ")
            local file = packet.script
            if fs.exists("scripts/" .. file) and not fs.isDir(file) and not packet.script:find("../", 1, true) then
                rednet.send(ID, "a")
                local rID, rPacket = rednet.receive(20) 
                if rID == ID and rPacket ~= "y" then
                    term.setTextColor(colors.red)
                    io.write("\n[LunROS] Client " .. ID .. " requested download for file: " .. packet.script .. " has been cancelled by client.\n")
                    term.setTextColor(colors.white)
                    io.write(var.user .. "@:~/" .. shell.dir() .. "$ ")
                else
                    term.setTextColor(colors.yellow)
                    io.write("\n[LunROS] Client " .. ID .. " downloading file: " .. packet.script .. ".\n")
                    term.setTextColor(colors.white)
                    io.write(var.user .. "@:~/" .. shell.dir() .. "$ ")
                    local localFile = io.open(("scripts/" .. file), "r")
                    local content = localFile:read("*a")
                    localFile:close()
                    rednet.send(ID, content)
                    term.setTextColor(colors.green)
                    io.write("\n[LunROS] Script: " .. file .. " downloaded to client " .. ID .. ".\n")
                    term.setTextColor(colors.white)
                    io.write(var.user .. "@:~/" .. shell.dir() .. "$ ")
                end
            else
                term.setTextColor(colors.red)
                io.write("\n[LunROS] Unknown file: " .. file .. ". Is the client smoking drugs?" .. ".\n")
                term.setTextColor(colors.white)
                io.write(var.user .. "@:~/" .. shell.dir() .. "$ ")
                rednet.send(ID, "Error: File can't be processed")
            end
            term.setTextColor(colors.white)
        end
    end
end
local function main()
    checkFiles()
    io.write("Public release.\n")
    io.write("[LunROS version: " .. var.vers .. "]\n")
    while var.run do
        io.write(var.user .. "@:~/" .. shell.dir() .. "$ ")
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
end
parallel.waitForAny(main, scriptFetch)