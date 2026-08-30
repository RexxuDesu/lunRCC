rednet.open("top")
local sender = 7
local signal = "front"
while true do
    local id, packet = rednet.receive()
    if id == sender then
        if packet == "1" then
            redstone.setOutput(signal, true)
            sleep(1)
            redstone.setOutput(signal, false)
        else
            print("Unknown message: " .. tostring(packet))
        end
    end
end
