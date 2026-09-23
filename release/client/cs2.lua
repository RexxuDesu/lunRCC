local speaker = peripheral.wrap("back")
shell.run("clear")
io.write("Enter pin: ")
local input = read("*")
if input == "7355608" then
    textutils.slowWrite("Bomb has been planted")
    sleep(1)
    local count = 30
    while count > 15 do
        shell.run("clear")
        print("Bomb has been planted")
        print(count)
        count = count - 1
            speaker.playSound("minecraft:block.note_block.harp")
            sleep(1)
    end
    while count > 10 do
        shell.run("clear")
        print("Bomb has been planted")
        print(count)
        count = count - 1
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.5)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.5)
    end
    while count > 5 do
        shell.run("clear")
        print("Bomb has been planted")
        print(count)
        count = count - 1
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.33)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.33)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.33)
    end
    while count > 2 do
        shell.run("clear")
        print("Bomb has been planted")
        print(count)
        count = count - 1
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.25)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.25)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.25)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.25)
    end
    while count > 0 do
        shell.run("clear")
        print("Bomb has been planted")
        print(count)
        count = count - 1
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(0.125)
    end
    if count == 0 then
        shell.run("clear")
        print("Terrorists Win")
        print(count)
        speaker.playSound("minecraft:entity.generic.explode")
    end
else print("Wrong pin.") end