textutils.slowPrint("Initializing...")
local function listen()
    while true do
        local targetID, targetMsg, targetProt = rednet.receive()
        if targetID then
            print("ID: " .. targetID .. "   MSG: " .. targetProt .. "   PRT: " .. targetProt)
        end
        sleep(1)
    end
end

while true do
    io.write("kali@:~ ")
    local input = read()
    if input then
        if input == "netS" then
            listen()
        end
    end
end