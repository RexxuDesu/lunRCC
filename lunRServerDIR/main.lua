--- lunRServer 1.5 ---
rednet.open("top")
local vers = "lunRServer Release 1.5"
local promptColor = colors.lime
local errorColor = colors.red
local successColor = colors.green
local goldColor = colors.yellow
local infoColor = colors.cyan
local filePath = fs.open("id.txt", "r")
local clientID = filePath.readLine()
local pck0 = ""
local pck2 = ""
local pck3 = ""
if clientID ~= nil and clientID:gsub("%s", "") ~= "" then
else
    print("Welcome to the initialization of the server!")
    filePath = fs.open("id.txt", "w")
    io.write("Enter client ID: ")
    local input = read()
    filePath.write(input)
	filePath = fs.open("id.txt", "r")
	clientID = filePath.readLine()
	clientID = tonumber(clientID)
	filePath.close()
    shell.run("clear")
end
local function changeClient()
        filePath = fs.open("id.txt", "w")
        io.write("Enter new client ID: ")
        local input = read()
        filePath.write(input)
        filePath = fs.open("id.txt", "r")
        clientID = filePath.readLine()
        clientID = tonumber(clientID)
        filePath.close()
        shell.run("clear")
end
clientID = tonumber(clientID)
local function inpRead()
    while true do
        io.write("server@:~$ ")
        term.setTextColor(colors.white)
        local inp = read()

        if inp == "help" then
            print("apt upd")
            print("apt -f upd")
            print("restart")
            print("clear")
            print("version")
            print("changeClient")
        elseif inp == "apt upd" then
            shell.run("updater")
        elseif inp == "apt -f upd" then
            shell.run("updaterForce")
        elseif inp == "apt -b upd" then
            shell.run("updaterBeta")
        elseif inp == "id" then
            print("Server ID is: #26")
        elseif inp == "restart" then
            shell.run("clear")
            return
            shell.run("startup")
		elseif inp == "clear" then
			shell.run("clear")
		elseif inp == "version" then
			term.setTextColor(goldColor)
			print(vers)
			term.setTextColor(colors.white)
        elseif inp == "changeClient" then
            changeClient()
        else
            print("Unknown command: " .. inp)
        end
    end
end
local function recvPacket()
    while true do
        local id, packet = rednet.receive()
        if id == clientID then
            if packet == "m0" then
                rednet.send(8, "TOGGLE")
            elseif packet == "m1" then
                rednet.send(9, "TOGGLE")
            elseif packet == "m2" then
                rednet.send(10, "TOGGLE")
            elseif packet == "m3" then
                rednet.send(11, "TOGGLE")
            elseif packet == "m4" then
                rednet.send(12, "TOGGLE")
            elseif packet == "m5" then
                rednet.send(13, "TOGGLE")
            elseif packet == "m6" then
                rednet.send(14, "TOGGLE")
            elseif packet == "m7" then
                rednet.send(15, "TOGGLE")
            elseif packet == "s0" then
                rednet.send(20, "TOGGLE")
            elseif packet == "s1" then
                rednet.send(21, "TOGGLE")
            elseif packet == "s2" then
                rednet.send(22, "TOGGLE")
            elseif packet == "up0" then
                rednet.send(19, "TOGGLE")
            elseif packet == "stat" then
                rednet.send(23, "status")
				rednet.send(24, "status")
				rednet.send(25, "status")
            end
        elseif id == 17 then
            if packet == "parse0" then
                rednet.send(clientID, "vaultFull_0")
            elseif packet == "parse1" then
                rednet.send(clientID, "vaultEmpty_0")
            end
        elseif id == 18 then
            if packet == "parse0" then
                rednet.send(clientID, "engineFail_0")
                rednet.send(27, "eas")
            elseif packet == "packet1" then
                rednet.send(27, "eas")
            end
        elseif id == 23 then
            local bool = false
            pck0 = packet
            if bool == false then
                rednet.send(clientID, "stat0")
                rednet.send(clientID, "")
                rednet.send(clientID, "stat0")
                rednet.send(clientID, pck0)
                bool = true
            end
        elseif id == 24 then
            local bool = false
            pck1 = packet
            if bool == false then
                rednet.send(clientID, "stat0")
                rednet.send(clientID, pck1)
                bool = true
            end
        elseif id == 25 then
            local bool = false
            pck2 = packet
            if bool == false then
                rednet.send(clientID, "stat0")
                rednet.send(clientID, pck2)
                rednet.send(clientID, "stat1")
                bool = true
            end
        end
    end
end

parallel.waitForAny(inpRead, recvPacket)