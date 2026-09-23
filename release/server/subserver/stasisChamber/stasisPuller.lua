if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local server = 0
local function pull()
    redstone.setOutput("front", true)
    sleep(0.1)
    redstone.setOutput("front", false)
    sleep(0.1)
    redstone.setOutput("front", true)
end
while true do
    local ID, packet = rednet.receive()
    if ID == server and packet == "1" then pull() end 
end
parallel.waitForAny(rednetRecv)