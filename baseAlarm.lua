local tape = peripheral.find("tape_drive")

os.loadAPI("touchpoint")
local t = touchpoint.new("top")

if not tape then -- Check if there is a Tape Drive
    error("Tapedrive not found",0)
end

local function wipe()
    local k = tape.getSize()
    tape.stop()
    tape.seek(-k)
    tape.stop()
    tape.seek(-90000)
    local s = string.rep("\xAA", 8192)
    for i = 1, k + 8191, 8192 do
        tape.write(s)
    end
    tape.seek(-k)
    tape.seek(-90000)
end


local function play()
    wipe()
    tape.stop()
    tape.seek(-tape.getSize()) -- go back to the start

    local h = http.get("https://github.com/ThomasBeHappy/ComputerCraftPrograms/blob/main/siren.dfpwm?raw=true", nil, true) -- write in binary mode
    tape.write(h.readAll()) -- that's it
    h.close()

    tape.seek(-tape.getSize()) -- back to start again
    tape.setSpeed(1)
    while tape.getState() ~= "STOPPED" do
      sleep(1)
    end
    tape.play()
end


local playing = false

local function playing()
    while true do
        if playing == true then
            if tape.getPosition() > 230000 then
                play()
            end
        end
        sleep(1)
    end
end


local function button()
    m = peripheral.wrap("top")
    local w, h  = m.getSize()

    t:add("ALARM", nil, 2, 2, w-1, h-1, colors.lime, colors.red)

    t:draw()

    while true do
        --# handleEvents will convert monitor_touch events to button_click if it was on a button
        local event, p1 = t:handleEvents(os.pullEvent())
        if event == "button_click" then
                t:toggleButton(p1)

                if playing == true then
                    t:rename(p1, "ALARM")
                    play()
                    playing = true
                else 
                    t:rename(p1, "STOP")
                    playing = false
                    tape.stop()
                    tape.seek(-tape.getSize()) -- back to start again
                end
        end
    end

end

parallel.waitForAll(button, playing)