shell.run("clear")
local scriptLinkID = "https://raw.githubusercontent.com/RexxuDesu/lunRCC/refs/heads/main/lunRServerDIR/main.lua"
local promptColor = colors.lime
local errorColor = colors.red
local successColor = colors.green
local goldColor = colors.yellow
local infoColor = colors.cyan

term.setTextColor(errorColor)
print("Are you sure you want to force update? (y/n): ")
term.setTextColor(colors.white)
local proceed = read():lower()

if proceed == "y" then
    print("Force updating...")
    shell.run("rm startup")
    local success, err = shell.run("pastebin get " .. scriptLinkID .. " startup")

    if success then
        term.setTextColor(successColor)
        print("Force update successful.")
        term.setTextColor(colors.white)
		shell.run("clear")
        shell.run("startup")
    else
        term.setTextColor(errorColor)
        print("Failed to force update: ", err)
        term.setTextColor(colors.white)
    end

else
    term.setTextColor(errorColor)
    print("Force update aborted.")
    term.setTextColor(colors.white)
end