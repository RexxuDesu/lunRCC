local var = {
    signal = "front",
}
local function give()
    redstone.setOutput(var.signal, true)
    sleep(0.1)
    redstone.setOutput(var.signal, false)
end
while true do
    local file = fs.open("time.txt", "r")
    local val = tonumber(file.readLine()) or 0
    file.close()
    if redstone.getOutput("top") == true then
        val = 18432
        file = fs.open("time.txt", "w")
        file.write(val)
        file.close()
        give()
    end
    if val > 0 then
        val = val - 1
        file = fs.open("time.txt", "w")
        file.write(val)
        file.close()
    end
    sleep(1)
end