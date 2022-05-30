local monitor = peripheral.wrap("right")

if monitor == nil then error("Requires a monitor attached") end

monitor.clear()

local pain = require("pixelterm").create(monitor)

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

    pain.setColor(colors.red)
    for key, door in pairs(doorStates) do
        pain.setLine(door.startPos.x, door.startPos.z, door.endPos.x, door.endPos.z)
    end
end

local function initialize()
    -- obj.setColor(color)
    -- Sets pixel color, errors if color is not set in colors.

    -- obj.getColor()
    -- Returns the currently selected color.

    -- obj.clear()
    -- Clears the screen with the selected color, this sets the specific text characters and is used inside of create().

    -- obj.setPixel(x, y [, color])
    -- Now here's the fun part, using this you can set individual pixels to different colors, if color is unspecified it defaults to obj.getColor()

    -- obj.getPixel(x, y)
    -- Returns the color of a pixel at the specified coordinates.

    -- obj.getSize()
    -- Returns the size of the pixel grid.

    -- obj.setLine(x1, y1, x2, y2, color)
    -- Draws a line of pixels from x1 and y1 to x2 and y2, also accepts colors.
    
    -- 100 width, 52 height

    pain.setColor(colors.black)
    pain.clear()
    
    pain.setColor(colors.white)
    -- Elevator hallway
    pain.setLine(60, 50, 64, 50)
    pain.setLine(60, 50, 60, 28)
    pain.setLine(64, 50, 64, 28)
    -- Hallway right
    pain.setLine(64, 28, 80, 28)
    pain.setLine(80, 33, 80, 28)
    pain.setLine(80, 33, 35, 28)
    -- Hallway left
    pain.setLine(60, 28, 10, 28)
    pain.setLine(10, 33, 10, 28)
    pain.setLine(10, 33, 31, 33)
    -- Hallway top
    pain.setLine(31, 99, 31, 33)
    pain.setLine(31, 99, 35, 99)
    pain.setLine(35, 33, 35, 99)

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