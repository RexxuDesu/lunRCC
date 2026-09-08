rednet.open(peripheral.getName(peripheral.find("modem")))
io.write("Enter script name to download: ")
local scriptName = read()
rednet.send(85, { action = "fetch", script = scriptName })
io.write("Requesting " .. scriptName .. " from server...\n")
local ID, packet = rednet.receive(5)
if ID == serverId then
    if packet:sub(1, 6) == "Error:" then print(packet)
    else
        local file = io.open("startup", "w")
        file:write(packet)
        file:close()
        print("Successfully downloaded and saved: " .. scriptName)
    end
else print("Error: Server did not respond.")
end