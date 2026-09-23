--[=====[ 
    UNFINISHED PROJECT
    will work on in the future, for now I can't do a working
    code because I have to focus on another script and this one
    will commit alongside the other script 
--]=====]
if not peripheral.find("modem") then io.write("[LOG] Unable to find modem. Qutting in 2s...\n") sleep(2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local function receive()
    while true do 
        local ID, packet = rednet.receive() 
        if ID ~= nil and packet ~= nil then
            sleep(2)
        end
    end
end
local function send(ID, packet)
    rednet.send(ID, "q")
    if packet == "y" then
    end
end
while true do
    for slot = 1, 9 do
        local item = (peripheral.wrap("top")).getItemDetail(slot)
    end
    io.write("[LOG] Sleeping for 10s...\n")
    sleep(10)
end