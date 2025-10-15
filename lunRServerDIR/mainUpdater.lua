local vers = "lunRServer Release 1.3"
local versFile = "version.txt"
local versLinkID = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/version.txt"
local scriptLinkID = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/main"
local promptColor = colors.lime
local errorColor = colors.red
local successColor = colors.green
local goldColor = colors.yellow
local infoColor = colors.cyan

print("Checking for updates...")
local success, err = shell.run("wget " .. versLinkID .. " " .. versFile)

if not success then
    term.setTextColor(errorColor)
    print("Failed to fetch version from Pastebin: ", err)
    term.setTextColor(colors.white)
end

if fs.exists(versFile) then
    local file = fs.open(versFile, "r")

    if file then
        local latestVersion = file.readLine()
        file.close()
        fs.delete(versFile)
        latestVersion = latestVersion:match("^%s*(.-)%s*$")
        vers = vers:match("^%s*(.-)%s*$")

        if latestVersion and latestVersion ~= vers then
            print("Latest version available: " .. latestVersion)
            print("Current version installed: " .. vers)
            term.setTextColor(successColor)
            io.write("Do you want to proceed with the update? (y/n): ")
            term.setTextColor(colors.white)
            local proceed = read()

            if proceed:lower() == "y" then
                print("[Software updating...")
                shell.run("rm startup")
                local success, err = shell.run("wget " .. scriptLinkID .. " startup")
                
                if success then
                    vers = latestVersion
                    term.setTextColor(successColor)
                    print("[sudo] Script updated to version " .. latestVersion)
                    term.setTextColor(colors.white)
                    return
                    shell.run("startup")
                else
                    term.setTextColor(errorColor)
                    print("Failed to update software: ", err)
                    term.setTextColor(colors.white)
                end
    
            else
                term.setTextColor(errorColor)
                print("Update aborted.")
                term.setTextColor(colors.white)
            end

        else
            term.setTextColor(successColor)
            print("No updates available. You are running the latest version.")
            term.setTextColor(colors.white)
        end

    else
        term.setTextColor(errorColor)
        print("Failed to open version file for reading.")
        term.setTextColor(colors.white)
    end

else
    print("Version file does not exist.")
end