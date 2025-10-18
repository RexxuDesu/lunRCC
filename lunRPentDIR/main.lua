textutils.slowPrint("Initializing...")
local function listen()
    while true do
        local targetID, targetMsg, targetProt = rednet.receive()
        if targetID then
            print("ID: " .. targetID .. "   MSG: " .. targetMsg .. "   PRT: " .. targetProt)
        end
        sleep(1)
    end
end

while true do
    textutils.slowPrint.io.write("kali@:~ ")
    local input = read()
    if input then
        if input == "netS" then
            shell.run("clear")
            textutils.slowPrint.io.write("Listening for any broadcast...")
            listen()
        end
    end
end