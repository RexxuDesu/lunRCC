if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local var = {
    craft = 60,
    server = 42,
    gate = 66,
    e0 = 134,
    e1 = 65,
    e2 = 63,
    e3 = 64,
    e4 = 62,
    fuel = 78
}
local wls = {7, 85} 
local x = 1
local y = 1
local ID, packet
local function display(msg)
    local monitor = peripheral.find("monitor")
    monitor.setTextScale(0.5)
    monitor.setCursorPos(x, y)
    monitor.write(os.date("[%H:%M:%S] ") .. msg)
    y = y + 1
end
local commands = {
    ["craft"] = function()
        rednet.send(var.craft, "1")
        display("ID: " .. ID .. " sent command: craft.\n")
    end,
    ["server"] = function()
        rednet.send(var.server, "1")
        display("ID: " .. ID .. " sent command: server.\n")
    end,
    ["gate"] = function()
        rednet.send(var.gate, "1")
        display("ID: " .. ID .. " sent command: gate.\n")
    end,
    ["e0"] = function()
        rednet.send(var.e0, "1")
        display("ID: " .. ID .. " sent command: e0.\n")
    end,
    ["e1"] = function()
        rednet.send(var.e1, "1")
        display("ID: " .. ID .. " sent command: e1.\n")
    end,
    ["e2"] = function()
        rednet.send(var.e2, "1")
        display("ID: " .. ID .. " sent command: e2.\n")
    end,
    ["e3"] = function()
        rednet.send(var.e3, "1")
        display("ID: " .. ID .. " sent command: e3.\n")
    end,
    ["e4"] = function()
        rednet.send(var.e4, "1")
        display("ID: " .. ID .. " sent command: e4.\n")
    end,
    ["fuel"] = function(args)
        local give = false
        local status = false
        for _, arg in ipairs(args) do
            if arg == "-g" then give = true
            elseif arg == "-s" then status = true
            end
        end
        if give then 
            rednet.send(var.fuel, "give")
            display("ID: " .. ID .. " sent command: fuel -g.\n")
        elseif status then
            rednet.send(var.fuel, "status")
            display("ID: " .. ID .. " sent command: fuel. -s\n")
            local recvID, packet = rednet.receive()
            if recvID == var.fuel then
                rednet.send(ID, packet)
            end
        end
    end,
}
while true do
    ID, packet = rednet.receive()
    for _, wl in ipairs(wls) do
        if ID == wl  then
            local command = packet.command
            local args = packet.args or {}
            if commands[command] then commands[command](args) end
        end
    end
    if ID == 119 then
        rednet.send(135, "1")
        sleep(0.5)
        rednet.send(140, "1")
        rednet.send(136, "1")
        sleep(0.2)
        rednet.send(139, "1")
        rednet.send(134, "1")
    elseif ID == 137 then
        rednet.send(135, "1")
        rednet.send(136, "1")
        sleep(0.2)
        rednet.send(139, "1")
        rednet.send(140, "1")
    end
end