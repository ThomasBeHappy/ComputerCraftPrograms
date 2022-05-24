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

        collective[message.id] = message
    end
end

function updateMonitor()
    while true do
        for index, value in ipairs(collective) do
            write("ID: " .. value.id)
            write("Name: " .. value.name)
        end
    end
end

parallel.waitForAll(receiveUpdates, updateMonitor)