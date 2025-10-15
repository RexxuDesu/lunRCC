--- lunRCommandRecv 1.3 ---
rednet.open("top")
local state = false
local filePath = fs.open("id.txt", "r")
local serverID = filePath.readLine()
if fs.exists("status.txt") then
    local status = fs.open("status.txt", "r")
    local line = status.readLine()
    status.close()
    if line then
        line = line:match("^%s*(.-)%s*$")
        if line == "true" then state = true end
    end
else
    local status = fs.open("status.txt", "w")
    status.write("false")
    status.close()
end
if serverID ~= nil and serverID:gsub("%s", "") ~= "" then
else
    filePath = fs.open("id.txt", "w")
    io.write("Enter server ID: ")
    local input = read()
    filePath.write(input)
	filePath = fs.open("id.txt", "r")
	serverID = filePath.readLine()
	serverID = tonumber(serverID)
	filePath.close()
end
serverID = tonumber(serverID)
redstone.setOutput("back", state)
while true do
    local id, msg = rednet.receive()

    if id == serverID and msg == "TOGGLE" then
        state = not state
        redstone.setOutput("back", state)

        local status = fs.open("status.txt", "w")
        status.write(tostring(state))
        status.close()
    end
end