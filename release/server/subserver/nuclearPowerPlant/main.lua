if not peripheral.find("modem") then io.write("Unable to find modem. Quitting in 2s...\n") sleep (2) os.reboot()
else rednet.open(peripheral.getName(peripheral.find("modem"))) end
local var = {
    min_sU1 = 0,
    min_sU2 = 0,
    min_sU3 = 0,
    min_sU4 = 0,
    min_sU5 = 0,
    min_sU6 = 0,
    max_sU1 = 0,
    max_sU2 = 0,
    max_sU3 = 0,
    max_sU4 = 0,
    max_sU5 = 0,
    max_sU6 = 0,
    pump11 = false,
    pump21 = false,
    pumpR1 = false,
    pump12 = false,
    pump22 = false,
    pumpR2 = false,
    pump13 = false,
    pump23 = false,
    pumpR3 = false,
    pump14 = false,
    pump24 = false,
    pumpR4 = false,
    pump15 = false,
    pump25 = false,
    pumpR5 = false,
    pump16 = false,
    pump26 = false,
    pumpR6 = false,
    status_fuel1 = false,
    status_fuel2 = false,
    status_fuel3 = false,
    status_fuel4 = false,
    status_fuel5 = false,
    status_fuel6 = false,
    items_fuel1 = 0,
    items_fuel2 = 0,
    items_fuel3 = 0,
    items_fuel4 = 0,
    items_fuel5 = 0,
    items_fuel6 = 0
}
local function process(ID, packet)
    if ID == then
        if packet
    end
end
local function receive()
    while true do
        local ID, packet = rednet.receive()
        if ID ~= nil and packet ~= nil then
            process(ID, packet)
        end
    end
end
local function main()
end
parallel.waitForAny(main, receive)