if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local iden = {134}
while true do
    local ID, packet = rednet.receive()
    if ID == iden[1] and packet == "1" then
        redstone.setOutput("front", true)
    elseif ID == iden[1] and packet == "0" then
        redstone.setOutput("back", false)
    end
end