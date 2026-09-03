local function getTime()
    local file = fs.open("time.txt", "r")
    local value = tonumber(file.readLine()) or 0
    file.close()
    return value
end
local function setTime(value)
    local file = fs.open("time.txt", "w")
    file.write(value)
    file.close()
end
local val = getTime()
local function give()
    if val == 0 then
        val = 18432
    elseif val > 0 then
        val = val + 18432
    end
    setTime(val)
    redstone.setOutput("front", true)
    sleep(0.1)
    redstone.setOutput("front", false)
    sleep(0.1)
    redstone.setOutput("front", true)
    sleep(0.1)
    redstone.setOutput("front", false)
    sleep(0.1)
end
local function cd()
    while true do
        if val > 0 then
            print(val / 60 .. " minutes")
            val = val - 1
            setTime(val)
        end
        sleep(1)
    end
end
local function rednetRecv()
    while true do
        local ID, packet = rednet.receive()
        if ID ~= 7 then 
            break 
        end
        if packet == "give" then
            give()
        elseif packet == "status" then
            rednet.send(ID, val)
        end
    end
end
parallel.waitForAny(cd, rednetRecv)