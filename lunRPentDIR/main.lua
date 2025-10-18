textutils.slowPrint("Initializing...")
local function listen()
    while true do
        local targetID, targetMsg, targetProt = rednet.receive()
        if targetID then
            textutils.slowPrint("ID: " .. targetID .. "   MSG: " .. targetMsg .. "   PRT: " .. targetProt)
        end
        sleep(1)
    end
end

while true do
    textutils.slowWrite("kali@:~ ")
    local input = read()
    if input then
        if input == "netS" then
            shell.run("clear")
            textutils.slowWrite("Listening...")
            listen()
        end
    end
end