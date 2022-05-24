local monitor = peripheral.wrap("right")

rednet.open("top")

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
        for index, value in ipairs(collective) do
            write("ID: " .. value.id, 1, 1)
            write("Name: " .. value.name, 1, 2)
        end

        sleep(1)

    end
end

parallel.waitForAll(receiveUpdates, updateMonitor)