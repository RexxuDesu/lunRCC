rednet.open(peripheral.getName(peripheral.find("modem")))
local var = {
    sender = 0,
    craft = 0,
    server = 0,
    gate = 0,
    e1 = 0,
    e2 = 0,
    e3 = 0,
    e4 = 0,
    fuel = 0
}
local function writeID(parse)
    local fileWrite = fs.open("id.txt", "w")
    io.write("Enter ID for " .. var.parse .. " ID: ")
    local input = read()
    fileWrite.write(input)
    var[parse] = tonumber(input)
    fileWrite.close()
end
local function checkFiles()
    if not fs.exists("id.txt") then
        local file = fs.open("id.txt", "w")
        file.write("7")
        file.close()
    end
    local file = fs.open("id.txt", "r")
    var.sender = tonumber(file.readLine())
    var.craft = tonumber(file.readLine())
    if var.craft == nil then
        writeID("craft")
    end
    var.server = tonumber(file.readLine())
    if var.server == nil then
        writeID("server")
    end
    var.gate = tonumber(file.readLine())
    if var.gate == nil then
        writeID("gate")
    end
    var.e1 = tonumber(file.readLine())
    if var.e1 == nil then
        writeID("e1")
    end
    var.e2 = tonumber(file.readLine())
    if var.e2 == nil then
        writeID("e2")
    end
    var.e3 = tonumber(file.readLine())
    if var.e3 == nil then
        writeID("e3")
    end
    var.e4 = tonumber(file.readLine())
    if var.e4 == nil then
        writeID("e4")
    end
    var.fuel = tonumber(file.readLine())
    if var.fuel == nil then
        writeID("fuel")
    end
    file.close()
end
checkFiles()
parallel.waitForAny