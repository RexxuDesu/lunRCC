if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local var = {
    user = nil,
    userR,
    userW,
    vers = "3.2.6.1",
    run = true,
    sts = false,
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
local scripts = {
    client = "wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/client/beta.lua scripts/client",
    rukeiSubServer = "wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/server/subserver/rednetReceiver.lua scripts/rukeiSubServer"
    stasisServer = "wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/server/subserver/stasisChamber/stasisServer.lua scripts/stasisServer"
    stasisPuller = "wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/release/server/subserver/stasisChamber/stasisPuller.lua scripts/stasisPuller"
}
local function cmdRes() -- DO NOT TOUCH
    term.setTextColor(colors.green)
    io.write(var.user .. "@:~$ Command sent!")
    term.setTextColor(colors.white)
end
local function parseCommand(input) -- DO NOT TOUCH
    local args = {}
    for word in string.gmatch(input, "%S+") do table.insert(args, word) end
    local command = table.remove(args, 1)
    return command, args
end
local function checkFiles()
    local complete = true
    if not fs.exists("scripts/") then shell.run("mkdir scripts/") end
    while complete do
        if not fs.exists("scripts/client") then shell.run(scripts.client) end
        if not fs.exists("scripts/rukeiSubServer") then shell.run(scripts.rukeiSubServer) end
        if not fs.exists("scripts/stasisServer") then shell.run(scripts.stasisServer) end
        if not fs.exists("scripts/stasisPuller") then shell.run(scripts.stasisPuller) end
        complete = false
        shell.run("clear")
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
local function stasis()
    while var.sts do
        local _, key = os.pullEvent("key")
        if key == keys.t then
            rednet.send(0, "1")
            var.sts = false
            return true
        elseif key == keys.v then
            rednet.send(0, "1")
            var.sts = false
            return true
        elseif key == keys.r then
            rednet.send(0, "1")
            var.sts = false
            return true
        end
    end
end
local commands = {
    ["help"] = function() io.write("Available commands: help | version | id | cuser | clear | cd | cp | mv | ls | nano | update | ex | craft | server | gate | ev | el | fuel | net | st\n") end,
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
            elseif args[2] then shell.run("cp " .. args[1] .. " " .. args[2]) end
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
            elseif args[2] then shell.run("mv " .. args[1] .. " " .. args[2]) end
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
        local script = false
        for _, arg in ipairs(args) do
            if arg == "-f" then force = true
            elseif arg == "-y" then yes = true
            elseif arg == "-s" then script = true
            else
                term.setTextColor(colors.red)
                print("Unknown option: " .. arg)
                term.setTextColor(colors.white)
                return false
            end
        end
        if script then
            shell.run("rm scripts/client")
            shell.run("rm scripts/rukeiSubServer")
            if not fs.exists("scripts/client") then shell.run(scripts.client) end
            if not fs.exists("scripts/rukeiSubServer") then shell.run(scripts.rukeiSubServer) end
            shell.run("clear")
            return true
        end
        if force then
            term.setTextColor(colors.red)
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
            sleep(1.3)
            shell.run("clear")
            var.run = false
        end
    end,
    ["craft"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("craft\n")
                io.write("Lifts/drop the crafting block in the Shinomiya Castle.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else
            rednet.send(var.mainServer, {command = "craft", args = {}})
            cmdRes()
        end
    end,
    ["server"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("server\n")
                io.write("Lifts/drop the server block in the Shinomiya Castle.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else
            rednet.send(var.mainServer, {command = "server", args = {}})
            cmdRes()
        end
    end,
    ["gate"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("gate\n")
                io.write("Opens/closes the gate in the Shinomiya Castle.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else
            rednet.send(var.mainServer, {command = "gate", args = {}})
            cmdRes()
        end
    end,
    ["ev"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("ev\n")
                io.write("Calls/controls the elevator in the Shinomiya Castle.\n")
                io.write("Syntax:\n")
                io.write("-h | Displays command info.\n")
                io.write("-1 | Calls elevator to the 1st floor.\n")
                io.write("-2 | Calls elevator to the 2nd floor.\n")
                io.write("-3 | Calls elevator to the 3rd floor.\n")
                io.write("-4 | Calls elevator to the 4th floor.\n")
            elseif args[1] == "-1" then
                rednet.send(var.mainServer, {command = "e1", args = {}})
                cmdRes()
            elseif args[1] == "-2" then
                rednet.send(var.mainServer, {command = "e2", args = {}})
                cmdRes()
            elseif args[1] == "-3" then
                rednet.send(var.mainServer, {command = "e3", args = {}})
                cmdRes()
            elseif args[1] == "-4" then
                rednet.send(var.mainServer, {command = "e4", args = {}})
                cmdRes()
            else
                term.setTextColor(colors.red)
                io.write("Unknown floor, did you type correctly?\n")
                term.setTextColor(colors.white)
            end
        else
            term.setTextColor(colors.red)
            io.write("Requires syntax: -h | -1 | -2 | -3 | -4.\n")
            term.setTextColor(colors.white)
        end
    end,
    ["el"] = function(args)
        if args[1] then
            if args[1] == "-h" then
                io.write("el\n")
                io.write("Locks the elevator in the Shinomiya Castle.\n")
            else
                term.setTextColor(colors.red)
                io.write("Command does not accept a syntax.\n")
                term.setTextColor(colors.white)
            end
        else
            rednet.send(var.mainServer, {command = "el", args = {}})
            cmdRes()
        end
    end,
    ["fuel"] = function(args)
        for _, arg in ipairs(args) do
            if arg ~= nil or arg ~= "" then
                if arg == "-s" or arg == "-g" then
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
                elseif arg == "-h" then
                    io.write("fuel\n")
                    io.write("Checks the nuclear tube in the Shinomiya Castle.\n")
                    io.write("Syntax:\n")
                    io.write("-h | Displays command info.\n")
                    io.write("-s | Checks how much time the fuel has left.\n")
                    io.write("-g | Gives fuel to the rods.\n")
                else 
                    term.setTextColor(colors.red)
                    io.write("Requires syntax: -h | -s | -g.\n")
                    term.setTextColor(colors.white)
                end
            end
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
            if fs.exists("scripts/" .. file) and not fs.isDir(file) then
                rednet.send(ID, "a")
                local rID, rPacket = rednet.receive(20) 
                if rID == ID and rPacket:lower() ~= "y" then
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