local server = 0
local function pull()
    redstone.setOutput("front", true)
    sleep(0.5)
    redstone.setOutput("front", false)
    sleep(0.5)
    redstone.setOutput("front", true)
    sleep(0.5)
    redstone.setOutput("front", false)
end
while true do
    local ID, packet = rednet.receive()
    if ID == server and packet == "1" then pull() end 
end
parallel.waitForAny(rednetRecv)