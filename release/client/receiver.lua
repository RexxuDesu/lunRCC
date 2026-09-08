-- script made in Rukei
if not peripheral.find("modem", rednet.open) then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local run = true
while run do
    io.write("Enter script name to download: ")
    local scriptName = read()
    io.write("Enter script name to save as: ")
    local scriptSource = read()
    io.write("Enter cloud ID: ")
    local cloud = read()
    rednet.send(cloud, { action = "fetch", script = scriptName })
    io.write("Requesting " .. scriptName .. " from cloud...\n")
    local ID, packet = rednet.receive(5)
    if ID == cloud then
        if packet:sub(1, 6) == "Error:" then print(packet)
        else
            local file = io.open(scriptSource, "w")
            file:write(packet)
            file:close()
            print("Successfully downloaded and saved: " .. scriptName)
        end
    else print("Error: Server did not respond.") end
end