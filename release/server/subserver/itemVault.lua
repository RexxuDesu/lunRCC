rednet.open(peripheral.getName(peripheral.find("modem")))
local var = {
    v = peripheral.find("inventory"),
    capacity = 0,
    contents = 0
}
local function read()
    var.capacity = 0
    var.contents = 0
    for slot = 1, var.v.size() do
        var.capacity = var.capacity + var.v.getItemLimit(slot)
        local item = var.v.getItemDetail(slot)
        if item then
            var.contents = var.contents + item.count
        end
    end
end
local function send()
    local data = {
        a = var.contents,
        b = var.capacity
    }
    rednet.send(67, data, "sensor")
end
while true do
    read()
    send()
    sleep(1)
end