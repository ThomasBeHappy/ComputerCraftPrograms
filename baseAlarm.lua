local tape = peripheral.find("tape_drive")

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

play()

while true do
    if tape.getPosition() > 230000 then
        play()
    end
    sleep(1)
end