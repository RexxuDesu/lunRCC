--[=====[ 
    UNFINISHED PROJECT
    will work on in the future, for now I can't do a working
    code because I have to focus on another script and this one
    will commit alongside the other script 
--]=====]
local m = peripheral.find("monitor")
m.clear()
local var = {
    status = true,
    pump1 = false,
    pump2 = false,
    fuel = 0,
    suMin = 0,
    suMax = 0
}
local function def()
    m.setCursorPos(1, 1)
    m.setTextScale(2)
    m.setTextColour(colors.red)
    m.write("REACTOR 1")
    m.setCursorPos(1, 3)
    m.setTextColour(colors.white)
    m.write("Fuel: ")
    if var.pump1 == false then
        m.setCursorPos(1, 5)
        m.setTextColour(colors.red)
        m.write("DOWN")
        m.setTextColour(colors.white)
    else
        m.setCursorPos(1, 5)
        m.setTextColour(colors.lime)
        m.write("UP")
        m.setTextColour(colors.white)
    end
    if var.pump2 == false then
        m.setCursorPos(1, 7)
        m.setTextColour(colors.red)
        m.write("DOWN")
        m.setTextColour(colors.white)
    else
        m.setCursorPos(1, 7)
        m.setTextColour(colors.lime)
        m.write("UP")
        m.setTextColour(colors.white)
    end
    m.setCursorPos(1, 10)
    m.write("SU: " .. var.suMin .. "/" .. var.suMax)
end
while true do
    def()
    sleep(1)
end