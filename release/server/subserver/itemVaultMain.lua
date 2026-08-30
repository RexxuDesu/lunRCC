rednet.open(peripheral.getName(peripheral.find("modem")))
local m = peripheral.find("monitor")
m.setTextScale(1)
local vaults = {
    [68] = "Woods",
    [69] = "Blocks",
    [70] = "Placeables",
    [71] = "Ingots",
    [72] = "Foods",
    [73] = "Plants",
    [74] = "Misc"
}
local order = {68, 69, 70, 71, 72, 73, 74}
local data = {}
local function loadData()
    for _, id in ipairs(order) do
        local filename = tostring(id) .. ".txt"
        if fs.exists(filename) then
            local file = fs.open(filename, "r")
            local contents = file.readAll()
            file.close()
            local func = load("return " .. contents)
            if func then
                local success, result = pcall(func)
                if success and type(result) == "table" then
                    data[id] = result
                end
            end
        end
    end
end
local function saveData(id, message)
    local filename = tostring(id) .. ".txt"
    local file = fs.open(filename, "w")
    file.write(textutils.serialize(message))
    file.close()
end
local function display()
    m.clear()
    local line = 1
    for _, id in ipairs(order) do
        local name = vaults[id]
        local vault = data[id]
        m.setCursorPos(1, line)
        if vault then
            local contents = vault.a
            local capacity = vault.b
            local percent = contents / capacity
            m.write(name .. ": " .. contents .. "/" .. capacity)
            line = line + 1
            m.setCursorPos(1, line)
            local barWidth = 20
            local filled = math.floor(percent * barWidth)
            filled = math.max(0, math.min(barWidth, filled))
            m.write("[")
            m.write(string.rep("#", filled))
            m.write(string.rep("-", barWidth - filled))
            m.write("] " .. string.format("%.1f%%", percent * 100))
        else
            m.write(name .. ": Waiting...")
        end
        line = line + 1
    end
end
loadData()
display()
while true do
    local senderID, message = rednet.receive("sensor")
    if vaults[senderID] then
        data[senderID] = message
        saveData(senderID, message)
        display()
    end
end