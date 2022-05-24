local monitor = peripheral.wrap("right")

rednet.open("top")

monitor.clear()
monitor.setCursorPos(1,1)

local collective = {}

local function write(input, x, y)
    local curX, curY = monitor.getCursorPos()
    curX = x or curX
    curY = y or curY 
    
    monitor.setCursorPos(curX, curY)
    monitor.write(input)
end

function tableHasKey(table,key)
    return table[key] ~= nil
end

function receiveUpdates()
    while true do
        local id, message = rednet.receive()

        collective[message.name] = message
    end
end

function updateMonitor()
    while true do
        monitor.clear()
        write("-- Collective Monitor -- ", 1, 1)
        local index = 0
        for key,value in pairs(collective) do --actualcode
            write("Name: " .. key, 1, 2 + index)
            write("Health: " .. math.floor(collective[key].player.health), 1, 3 + index)
            write("Hunger: " .. math.floor(collective[key].player.food.hunger), 1, 4 + index)
            write("Saturation: " .. math.floor(collective[key].player.food.saturation), 1, 5 + index)
            index = index + 5
        end

        sleep(1)

    end
end

parallel.waitForAll(receiveUpdates, updateMonitor)