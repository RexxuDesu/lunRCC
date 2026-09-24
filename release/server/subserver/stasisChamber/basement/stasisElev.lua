if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local iden = {41, 135, 136}
while true do
    local ID, packet = rednet.receive()
    if ID == iden[1] and packet == "1" then
        rednet.send(iden[2], "1")
        sleep(0.7)
        rednet.send(iden[3], "1")
        sleep(0.7)
        redstone.setOutput("front", true)
        sleep(0.3)
        redstone.setOutput("front", false)
    elseif ID == iden[1] and packet == "0" then
        rednet.send(iden[3], "0")
        sleep(0.7)
        rednet.send(iden[2], "0")
    end
end