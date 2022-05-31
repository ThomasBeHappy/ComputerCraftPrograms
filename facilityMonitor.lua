local monitor = peripheral.wrap("right")

if monitor == nil then error("Requires a monitor attached") end

monitor.clear()

term.redirect(monitor)

rednet.open("top")

-- 15 doors
local doorStates = {}
local doorCount = 15

-- on start draw out the layout of the facility on the monitor with all doors on OFF

-- broadcast a ping signal, wait for computers to send a message back with their current states.

-- Update monitor with received Data

-- Wait for updates to the states and update monitor accordingly

local function initDoors()
    for i = 1, doorCount, 1 do
        doorStates[i] = {startPos = {x = 1, z = 1}, endPos = {x = 1, z = 1}, state = false}
    end

    doorStates[1].startPos = {x = 60, z = 47}
    doorStates[1].endPos = { x = 60, z = 49}

    doorStates[1].startPos = {x = 64, z = 47}
    doorStates[1].endPos = { x = 64, z = 49}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    doorStates[1].startPos = {x = 1, z = 1}
    doorStates[1].endPos = { x = 1, z = 1}

    for key, door in pairs(doorStates) do
        paintutils.drawLine(door.startPos.x, door.startPos.z, door.endPos.x, door.endPos.z, colors.red)
    end
end

local function initialize()
    
    -- 100 width, 52 height
    
    paintutils.drawLine(1, 1, 100, 1, colors.white)
    -- Elevator hallway
    paintutils.drawLine(60, 50, 64, 50, colors.white)
    paintutils.drawLine(60, 50, 60, 28, colors.white)
    paintutils.drawLine(64, 50, 64, 28, colors.white)
    -- Hallway right
    paintutils.drawLine(64, 28, 80, 28, colors.white)
    paintutils.drawLine(80, 33, 80, 28, colors.white)
    paintutils.drawLine(80, 33, 35, 28, colors.white)
    -- Hallway left
    paintutils.drawLine(60, 28, 10, 28, colors.white)
    paintutils.drawLine(10, 33, 10, 28, colors.white)
    paintutils.drawLine(10, 33, 31, 33, colors.white)
    -- Hallway top
    paintutils.drawLine(31, 99, 31, 33, colors.white)
    paintutils.drawLine(31, 99, 35, 99, colors.white)
    paintutils.drawLine(35, 33, 35, 99, colors.white)

    initDoors()
end

local function ping()
    rednet.broadcast("DOORSERVER_PING")

    -- while true do
    --     local id, message = rednet.receive()

    -- end

end

local function drawMap()
    
end

local function receiveUpdate()
    
end

initialize()

ping()

drawMap()

parallel.waitForAll(receiveUpdate, drawMap)