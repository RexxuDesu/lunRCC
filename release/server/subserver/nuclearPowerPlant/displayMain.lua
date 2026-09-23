--[=====[ 
    UNFINISHED PROJECT
    will work on in the future, for now I can't do a working
    code because I have to focus on another script and this one
    will commit alongside the other script 
--]=====]
local m = peripheral.find("monitor")
local function def()
    m.clear()
    m.setTextScale(1)
    m.setCursorPos(1, 1)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 1)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 2)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 2)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 4)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 4)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 5)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 5)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 7)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 7)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 8)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 8)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 10)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 10)
    m.write("H:M [] % UP")
    m.setCursorPos(1, 11)
    m.write("UP % [] H:M")
    m.setCursorPos(40, 11)
    m.write("H:M [] % UP")
    m.setTextScale(1)
    m.setCursorPos(25, 6)
    m.write("ON")
end
local function warn()
    m.clear()
    m.setTextScale(2)
    m.setCursorPos(25, 6)
    m.setTextColour(colors.red)
    m.write("SYSTEMS OFFLINE")
    m.setTextColour(colors.white)
end
local function display()
    
end
while true do
    def()
    sleep(1)
    warn()
    sleep(1)
end