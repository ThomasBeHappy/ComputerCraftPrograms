shell.run("/usr/bin/easy-shell execute")
rednet.open("back")

os.loadAPI("touchpoint")

local t = touchpoint.new()

local w, h = term.getSize()

t:add("Open", nil, 2, 2, w-1, h-1, colors.red, colors.lime)

t:draw()

while true do
    --# handleEvents will convert monitor_touch events to button_click if it was on a button
    local event, p1 = t:handleEvents(os.pullEvent())
    if event == "button_click" then
            t:flash(p1)

            rednet.send(0, "open")
    end
end