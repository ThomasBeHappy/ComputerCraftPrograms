local monitor = peripheral.wrap("left")

local backgroundColor = colors.cyan
local todoColor = colors.red
local doneColor = colors.green

local function write(input, x, y, color)
    local curX, curY = monitor.getCursorPos()
    curX = x or curX
    curY = y or curY 
    
    monitor.setCursorPos(curX, curY)
    monitor.blit(input, color, backgroundColor)
end


-- Have a table containing all TODO items

-- Function constantly updating the monitor with the items

-- terminal inside PC has choice screen for removing/adding/completing items on the TODO list

local todo = {}

local function updateMonitor()
    while true do
        local index = 0
        for key,value in pairs(todo) do
            if value.todo == true then
                write(key .. ". " .. value.name, 1, 2 + index, todoColor)
            else 
                write(key .. ". " .. value.name, 1, 2 + index, doneColor)
            end

            index = index + 1
        end
    end
end


local function newItem()
    while true do
        print("New Item: ")
        local input = read()

        if input ~= nil then
            table.insert(todo, {name = input, todo = true})
            print(input .. " added to TODO list.")
        end

        sleep(0.2)
    end
end

monitor.clear()
monitor.setCursorPos(1,1)
monitor.setBackgroundColour(backgroundColor)
monitor.setTextScale(0.5)


parallel.waitForAll(updateMonitor, newItem)