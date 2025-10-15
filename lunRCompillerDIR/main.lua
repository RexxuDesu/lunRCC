local version = "lunRCompiller Beta 0.4.3"
local versionFile = "version.txt"
local versionLinkID = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRCompillerDIR/version.txt"
local scriptLinkID = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRCompillerDIR/main.lua"
local filePath = fs.open("installedApps.txt", "r")
pagePrint
local function pagePrint()
    shell.run("clear")
    print("===== LUNARCOMPILLER =====")
    print("To install a program, enter a number.")
    print("[0] Lunar Software")
    print("[1] Lunar Server")
    print("[x] Vault Reader")
    print("[x] Vault Detector")
    print("[4] EAS Receiver")
    print("[5] Engine Detector")
    print("[6] Status Receiver")
    print("[7] Exit")
end
local function update()
    print("[installer] Checking for updates...")
    local success, err = shell.run("wget " .. versionLinkID .. " " .. versionFile)
    if not success then
		term.setTextColor(colors.red)
        print("[installer] Failed to fetch version information from Pastebin:", err)
		term.setTextColor(colors.white)
    end
    if fs.exists(versionFile) then
        local file = fs.open(versionFile, "r")
        if file then
            local latestVersion = file.readLine()
            file.close()
            fs.delete(versionFile)
            latestVersion = latestVersion:match("^%s*(.-)%s*$")
            version = version:match("^%s*(.-)%s*$")
            if latestVersion and latestVersion ~= version then
                print("[installer] Latest version available: " .. latestVersion)
                print("[installer] Current installed version: " .. version)
				term.setTextColor(colors.green)
                io.write("[installer] Do you want to proceed with the update? (y/n): ")
				term.setTextColor(colors.white)
                local proceed = read()
                if proceed:lower() == "y" then
                    print("[installer] Updating...")
                    shell.run("rm installer")
                    local success, err = shell.run("wget " .. scriptLinkID .. " installer")
                    if success then
                        version = latestVersion
						term.setTextColor(colors.green)
                        print("[installer] Script updated to version " .. latestVersion)
						term.setTextColor(colors.white)
                        print("[installer] Returning in 5s...")
                        sleep(5)
                        shell.run("clear")
                        shell.run("installer")
                    else
						term.setTextColor(colors.red)
                        print("[installer] Failed to update script:", err)
						term.setTextColor(colors.white)
                        print("[installer] Returning in 5s...")
                        sleep(5)
                        shell.run("clear")
                        shell.run("installer")
                    end
                else
					term.setTextColor(colors.red)
                    print("[installer] Update aborted.")
					term.setTextColor(colors.white)
                    print("[installer] Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                end
            else
				term.setTextColor(colors.green)
                print("[installer] No updates available. You are running the latest version.")
				term.setTextColor(colors.white)
                print("[installer] Returning in 5s...")
                sleep(5)
                shell.run("clear")
                shell.run("installer")
            end
        else
			term.setTextColor(colors.red)
            print("[installer] Failed to open version file for reading.")
			term.setTextColor(colors.white)
            print("[installer] Returning in 5s...")
            sleep(5)
            shell.run("clear")
            shell.run("installer")
        end
    else
        print("[installer] Version file does not exist.")
        print("[installer] Returning in 5s...")
        sleep(5)
        shell.run("clear")
        shell.run("installer")
    end
end
local function updateForce()
	term.setTextColor(colors.red)
    print("[installer] Are you sure you want to force update? (y/n): ")
	term.setTextColor(colors.white)
    local proceed = read():lower()
    if proceed == "y" then
        print("[installer] Force updating...")
        shell.run("rm installer")
        local success, err = shell.run("wget " .. scriptLinkID .. " installer")
        if success then
            term.setTextColor(colors.green)
            print("[installer] Force update successful.")
            term.setTextColor(colors.white)
            print("[installer] Returning in 5s...")
            sleep(5)
            shell.run("clear")
            shell.run("installer")
        else
            term.setTextColor(colors.red)
            print("[installer] Failed to force update:", err)
            term.setTextColor(colors.white)
            print("[installer] Returning in 5s...")
            sleep(5)
            shell.run("clear")
            shell.run("installer")
        end
    else
		term.setTextColor(colors.red)
        print("[installer] Force update aborted.")
		term.setTextColor(colors.white)
        print("[installer] Returning in 5s...")
        sleep(5)
        shell.run("clear")
        shell.run("installer")
    end
end
while true do
    local input = read()
    if input then
        shell.run("clear")
        if input == "0" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: Lunar Software")
					shell.run("rm startup")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRTerminalDIR/main.lua startup")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: Lunar Software")
                    shell.run("rm startup")
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: Lunar Software")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRTerminalDIR/main.lua startup")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "1" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: Lunar Server")
					shell.run("rm startup")
					if fs.exists("updater") then
						shell.run("rm updater")
					end
					if fs.exists("updater") then
						shell.run("rm updaterForce")
					end
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/main.lua startup")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/mainUpdater.lua updater")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/mainUpdaterForce.lua updaterForce")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: Lunar Server")
                    shell.run("rm startup")
					if fs.exists("updater") then
						shell.run("rm updater")
					end
					if fs.exists("updater") then
						shell.run("rm updaterForce")
					end
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: Lunar Server")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/main.lua startup")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/mainUpdater.lua updater")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/mainUpdaterForce.lua updaterForce")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "2" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: Vault Reader")
					shell.run("rm startup")
                    shell.run("wget startup")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: Vault Reader")
                    shell.run("rm startup")
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: Vault Reader")
                    shell.run("wget  startup")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "3" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: Vault Detector")
					shell.run("rm startup")
                    shell.run("wget startup")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: Vault Detector")
                    shell.run("rm startup")
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: Vault Detector")
                    shell.run("wget  startup")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "4" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: EAS Receiver")
					shell.run("rm startup")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunROtherDIR/lunReasRecv.lua startup")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: EAS Receiver")
                    shell.run("rm startup")
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: EAS Receiver")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunROtherDIR/lunReasRecv.lua startup")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "5" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: Engine Detector")
					shell.run("rm startup")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunROtherDIR/lunREngineCheck.lua startup")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: Engine Detector")
                    shell.run("rm startup")
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: Engine Detector")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunROtherDIR/lunREngineCheck.lua startup")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "6" then
            input = ""
            print("===== LUNARCOMPILLER =====")
            sleep(0.1)
            if fs.exists("startup") then
                print("Program is already installed or another program is already installed")
                print("[0] Return")
				print("[1] Reinstall")
                print("[2] Uninstall")
                input = read()
                if input == "0" then
                    shell.run("clear")
                    shell.run("installer")
				elseif input == "1" then
					shell.run("[installer] reinstalling: Status Receiver")
					shell.run("rm startup")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunROtherDIR/lunRCommandRecv.lua startup")
                    print("[installer] Successfully reinstalled! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")

                elseif input == "2" then
					shell.run("[installer] uninstalling: Status Receiver")
                    shell.run("rm startup")
                    print("[installer] Successfully removed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            else
				print("Program is not yet installed.")
                print("[0] Install")
                input = read()
                if input == "0" then
                    print("[installer] installing: Status Receiver")
                    shell.run("wget https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunROtherDIR/lunRCommandRecv.lua startup")
                    if fs.exists("id.txt") then
                    else
                        local f = fs.open("id.txt", "w")
                        f.write("")
                        f.close()
                    end
					print("[installer] Successfully installed! Returning in 5s...")
                    sleep(5)
                    shell.run("clear")
                    shell.run("installer")
                else
                    print("Unknown syntax: " .. input)
                    sleep(2)
                    pagePrint()
                end
            end
        elseif input == "7" then
            print("[installer] exiting program... Goodbye!")
            sleep(3)
            shell.run("exit")
        elseif input == "apt upd" then
            print("===== LUNARCOMPILLER =====")
            print("[installer] updating...")
            sleep(3)
            update()
        elseif input == "apt -f upd" then
            print("===== LUNARCOMPILLER =====")
            print("[installer] updating...")
            sleep(3)
            updateForce()
		else
			print("Unknown syntax: " .. input)
        end
    end
end
