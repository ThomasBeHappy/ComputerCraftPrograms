local monitor = peripheral.wrap("right")

if monitor == nil then error("Requires a monitor attached") end

local api = require("pixelbox")
local box = api.new(monitor)

box:clear(colors.lightGray)

rednet.open("top")

-- 15 doors
local doorStates = {}
local doorCount = 15

-- on start draw out the layout of the facility on the monitor with all doors on OFF

-- broadcast a ping signal, wait for computers to send a message back with their current states.

-- Update monitor with received Data

-- Wait for updates to the states and update monitor accordingly


-- list of computer ID's, with doors
local authorized = {{id = 8, doors = {1,3} }, {id = 7, doors = {2,4}} }

local function drawMap()
    while true do
        for key, door in pairs(doorStates) do

            if door.state then
                box:set_line(door.startPos.x, door.startPos.z, door.endPos.x, door.endPos.z, colors.red, 1)
            else 
                box:set_line(door.startPos.x, door.startPos.z, door.endPos.x, door.endPos.z, colors.green, 1)
            end
        end
    
        
        box:push_updates()
        box:draw()

        sleep(1)
    end
end

local function initDoors()
    for i = 1, doorCount, 1 do
        doorStates[i] = {startPos = {x = 1, z = 1}, endPos = {x = 1, z = 1}, state = false}
    end

    doorStates[1].startPos = {x = 35, z = 15}
    doorStates[1].endPos = { x = 35, z = 13}

    doorStates[2].startPos = {x = 39, z = 15}
    doorStates[2].endPos = { x = 39, z = 13}

    doorStates[3].startPos = {x = 35, z = 19}
    doorStates[3].endPos = { x = 35, z = 21}

    doorStates[4].startPos = {x = 39, z = 19}
    doorStates[4].endPos = { x = 39, z = 21}

    doorStates[5].startPos = {x = 1, z = 1}
    doorStates[5].endPos = { x = 1, z = 1}

    doorStates[6].startPos = {x = 1, z = 1}
    doorStates[6].endPos = { x = 1, z = 1}

    doorStates[7].startPos = {x = 1, z = 1}
    doorStates[7].endPos = { x = 1, z = 1}

    doorStates[8].startPos = {x = 1, z = 1}
    doorStates[8].endPos = { x = 1, z = 1}

    doorStates[9].startPos = {x = 1, z = 1}
    doorStates[9].endPos = { x = 1, z = 1}

    doorStates[10].startPos = {x = 1, z = 1}
    doorStates[10].endPos = { x = 1, z = 1}

    doorStates[11].startPos = {x = 1, z = 1}
    doorStates[11].endPos = { x = 1, z = 1}

    doorStates[12].startPos = {x = 1, z = 1}
    doorStates[12].endPos = { x = 1, z = 1}

    doorStates[13].startPos = {x = 1, z = 1}
    doorStates[13].endPos = { x = 1, z = 1}

    doorStates[14].startPos = {x = 1, z = 1}
    doorStates[14].endPos = { x = 1, z = 1}

    doorStates[15].startPos = {x = 1, z = 1}
    doorStates[15].endPos = { x = 1, z = 1}

    for key, door in pairs(doorStates) do
        box:set_line(door.startPos.x, door.startPos.z, door.endPos.x, door.endPos.z, colors.red, 1)
    end
end

local function initialize()
    
    -- 100 width, 52 height
    
    -- Elevator hallway
    box:set_line(35, 10, 39, 10, colors.white, 1)
    box:set_line(35, 10, 35, 28, colors.white, 1)
    box:set_line(39, 10, 39, 28, colors.white, 1)
    -- Hallway right
    box:set_line(39, 28, 80, 28, colors.white, 1)
    box:set_line(80, 33, 80, 28, colors.white, 1)
    box:set_line(80, 33, 59, 33, colors.white, 1)
    -- Hallway left
    box:set_line(35, 28, 10, 28, colors.white, 1)
    box:set_line(10, 33, 10, 28, colors.white, 1)
    box:set_line(10, 33, 55, 33, colors.white, 1)
    -- Hallway top
    box:set_line(55, 50, 55, 33, colors.white, 1)
    box:set_line(55, 50, 59, 50, colors.white, 1)
    box:set_line(59, 33, 59, 50, colors.white, 1)

    initDoors()

    box:push_updates()
    box:draw()
end


local function receiveUpdate()
    rednet.broadcast("DOORSERVER_PING")

    while true do
        local id, message = rednet.receive()

        if authorized[id] ~= nil then
            for index, value in ipairs(authorized[id].doors) do
                doorStates[index].state = message.doors[index]
            end
        end
    end
end

initialize()

parallel.waitForAll(receiveUpdate, drawMap)