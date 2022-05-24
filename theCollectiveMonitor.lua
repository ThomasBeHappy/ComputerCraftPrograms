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
        print(collective["Gaming_Frame"])

        for key,value in pairs(collective) do --actualcode
            write("Name: " .. key)
            write("ID: " .. collective[key].id)
        end

        sleep(1)

    end
end

parallel.waitForAll(receiveUpdates, updateMonitor)