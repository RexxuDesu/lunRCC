rednet.open("back")
local var = {
    user = nil,
    userR,
    userW,
    run = true
}
local path = {
    user = "user.txt",
    curVers = "verion.txt",
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
        io.write(var.user .. "@:~$ Enter new user: ")
        local input = read()
        file.write(input)
        file.close()
        file = fs.open(path.user, "r")
        var.user = file.readLine()
        file.close()
    end,
    ["clear"] = function()
        shell.run("clear")
    end,
    ["update"] = function()
        update()
    end,
    ["test"] = function()
        io.write(var.user .. "@:~$ Hello!")
    end
}
local function update()
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
            file = fs.open(path.curVers, "r")
            local curVers = file.readLine()
            file.close()
            latVers = latVers:match("^%s*(.-)%s*$")
            curVers = curVers:match("^%s*(.-)%s*$")
            if latVers ~= curVers then
                print("Latest version available: " .. latVers .. ". Current version: " .. curVers)
                term.setTextColor(colors.green)
                io.write("Do you want to proceed with the update? (y/n): ")
				term.setTextColor(colors.white)
                local proceed = read()
                if proceed:lower() == "y" then
                    io.write("Updating...")
                    shell.run("rm startup")
                    local suc, err = shell.run("wget " .. link.update .. " startup")
                    if suc then
                        file = fs.open(path.curVers, "w")
                        file.write(latVers)
                        file.close()
                        term.setTextColor(colors.green)
                        print("Updated to version " .. latVers)
						term.setTextColor(colors.white)
                        io.write("Rebooting in 2s...")
                        sleep(2)
                        os.reboot()
                    else
                        term.setTextColor(colors.red)
                        print("Failed to update script: ", err)
						term.setTextColor(colors.white)
                    end
                else
                    term.setTextColor(colors.red)
                    io.write("Update aborted.")
                    term.setTextColor(colors.white)
                end
            else
                term.setTextColor(colors.green)
                io.write("No current updates available.")
                term.setTextColor(colors.white)
            end
        else
            term.setTextColor(colors.red)
            print("Failed to read file.")
			term.setTextColor(colors.white)
        end
    end
end
local function checkFiles()
    if not fs.exists(path.curVers) then
        local file = fs.open(path.curVers, "w")
        file.write("1")
        file.close()
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
checkFiles()
while var.run do
    io.write(var.user .. "@:~$ ")
    local input = read()
    if commands[input] then
        commands[input]()
    else
        term.setTextColor(colors.red)
        io.write("Unknown command: " .. input)
        term.setTextColor(colors.white)
    end
end