local var = {
    local tankLeft = peripheral.wrap("left"),
    local tankRight = peripheral.wrap("right"),
    local tankReserve = peripheral.wrap("front"),
    local waterLeft = true,
    local waterRight = true,
    local waterFront = true
}
while true do
    local fluidLeft = var.tankLeft.tanks()
    local fluidRight = var.tankRight.tanks()
    local fluidReserve = var.tankReserve.tanks()
    local tankL = #fluidLeft > 0 and fluidsLeft[1].amount > 0
    local tankR = #fluidRight > 0 and fluidsRight[1].amount > 0
    local tankF = #fluidFront > 0 and fluidsFront[1].amount > 0
    local time = os.date("[%H:%M:%S]")
    if tankL and not var.waterLeft then
        print(time .. " Left tank: Water present.")
    elseif not tankL and var.waterLeft then
        print(time .. " Left tank: No water.")
    end
    if tankR and not var.waterRight then
        print(time .. " Right tank: Water present.")
    elseif not tankR and var.waterRight then
        print(time .. " Right tank: No water.")
    end
    if tankF and not var.waterFront then
        print(time .. " Front tank: Water present.")
    elseif not tankF and var.waterFront then
        print(time .. " Front tank: No water.")
    end
    var.waterL = tankL
    var.waterR = tankR
    var.waterF = tankF
end