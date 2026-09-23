local puller = {0, 0, 0}
local wls = {7, 85, 0, 0}
while true do
    local ID, packet = rednet.receive()
    for _, wl in ipairs(wls) do
        if ID == wl then
            if ID == wls[1] and packet == "1" or ID == wls[2] and packet == "1" then
                rednet.send(puller[1], "1")             
            elseif ID == wls[3] and packet == "1" then
                rednet.send(puller[2], "1")
            elseif ID == wls[4] and packet == "1" then
                rednet.send(puller[3], "1")
            end
        end
    end
end