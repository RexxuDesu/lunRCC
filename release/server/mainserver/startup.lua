rednet.open(peripheral.getName(peripheral.find("modem")))
local var = {
    craft = 60,
    server = 42,
    gate = 66,
    e1 = 65,
    e2 = 63,
    e3 = 64,
    e4 = 62,
    fuel = 78
}
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
    if ID == 7 or ID == 85 then
        local command = packet.command
        local args = packet.args or {}
        if commands[command] then
            commands[command](args)
        end
    end
end