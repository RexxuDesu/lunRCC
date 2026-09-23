if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local puller = {0, 0, 0}
local wls = {7, 85, 0, 0}
while true do
    local ID, packet = rednet.receive()
    if ID == wls[1] and packet == "1" or ID == wls[2] and packet == "1" then
        rednet.send(puller[1], "1")             
    elseif ID == wls[3] and packet == "1" then
        rednet.send(puller[2], "1")
    elseif ID == wls[4] and packet == "1" then
        rednet.send(puller[3], "1")
    end
end