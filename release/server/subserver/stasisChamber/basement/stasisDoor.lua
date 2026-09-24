if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
while true do
    local ID, packet = rednet.receive()
    if ID == 41 and packet == "1" then
        redstone.setOutput("front", true)
        sleep(0.3)
        redstone.setOutput("back", false)
    end
end