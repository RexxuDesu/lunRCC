-- script made in Rukei
if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local run = true
while run do
    io.write("Enter script name to download: ")
    local scriptName = read()
    io.write("Enter script name to save as: ")
    local scriptSource = read()
    io.write("Enter cloud ID: ")
    local cloud = tonumber(read())
    io.write("Requesting " .. scriptName .. " from cloud...\n")
    rednet.send(cloud, { action = "fetch", script = scriptName })
    local ID, packet = rednet.receive(5)
    if ID == cloud and packet:lower() == "a" then
        io.write("Package: " .. scriptName .. " is available, install? (y/n): ")
        local input = read()
        if input:lower() == "y" then 
            rednet.send(ID, "y")
            ID, packet = rednet.receive(5)
            local file = io.open(scriptSource, "w")
            file:write(packet)
            file:close()
            print("Successfully downloaded and saved: " .. scriptName)
        else 
            rednet.send(ID, "n")
            io.write("Installation cancelled.\n") 
        end
    elseif ID == cloud and packet:lower() ~= "a" then io.write("Unknown package: " .. scriptName .. "\n")
    else print("Error: Server did not respond.") end
end