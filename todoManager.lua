os.loadAPI("touchpoint")

local monitor = peripheral.wrap("right")

local t = touchpoint.new("right")

local backgroundColor = colors.cyan
local todoColor = colors.red
local doneColor = colors.green

local function write(input, x, y, color)
    local curX, curY = monitor.getCursorPos()
    curX = x or curX
    curY = y or curY 
    
    monitor.setCursorPos(curX, curY)
    monitor.setTextColour(color)
    monitor.write(input)
end



-- Have a table containing all TODO items

-- Function constantly updating the monitor with the items

-- terminal inside PC has choice screen for removing/adding/completing items on the TODO list

local todo = {}

local function updateMonitor()
    while true do
        local index = 0

        -- VERY DIRTY FIX AND SOMETHING I SHOULD NOT KEEP
        t = touchpoint.new("right")

        for key,value in pairs(todo) do

            local l = string.len(key .. ". " .. value.name)

            if value.todo == true then
                write(key .. ". " .. value.name, 1, 2 + index, todoColor)
            else 
                write(key .. ". " .. value.name, 1, 2 + index, doneColor)
            end
            write("------------------------------------------------------------------------", 1, 3 + index, colors.black)
            index = index + 2

            t:add("Mark", function () todo[key].todo = not todo[key].todo end, l, 2 + index, l + 6, 2 + index, colors.lime)
            
        end

        t:draw()

        sleep(1)
    end
end


local function newItem()
    while true do
        monitor.clear()
        print("New Item: ")
        local input = read()

        if input ~= nil then
            table.insert(todo, {name = input, todo = true})
            print(input .. " added to TODO list.")
        end

        sleep(1)
    end
end

function run()
    t:run()
end

monitor.clear()
monitor.setCursorPos(1,1)
monitor.setBackgroundColour(backgroundColor)
monitor.setTextScale(0.5)

parallel.waitForAll(updateMonitor, newItem, run)