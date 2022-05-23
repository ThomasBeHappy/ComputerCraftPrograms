rednet.open("back")

redstone.setOutput("bottom", true)

while true do
    local id, message = rednet.receive()

    if message == "open" then
        redstone.setOutput("bottom", false)
        sleep(1)
        redstone.setOutput("bottom", true)
    end
end