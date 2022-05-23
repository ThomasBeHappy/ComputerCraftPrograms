local box = peripheral.find("chatBox") -- Finds the peripheral if one is connected

if box == nil then error("chatBox not found") end

rednet.open("right")

while true do
    local senderID , message = rednet.receive() --# Waits for a message
    if message == "launch" then
        sleep(10)
        box.sendMessage("Launch sequence has been initiated.")
        sleep(1)
        box.sendMessage("Launching Silo #1.")
        sleep(2)
        box.sendMessage("ERROR: Silo #1 failed to launch.")
        sleep(3)
        box.sendMessage("Contacting other silo's.")
        sleep(5)
        box.sendMessage("5 silo's operational. #4 #2 #7 #8 #9")
        sleep(1)
        box.sendMessage("Firing Silo's #2 #4")
        sleep(2)
        box.sendMessage("#2: Launch succeeded.")
        redstone.setOutput("front", true)
        sleep(2)
        box.sendMessage("#4: Launch succeeded.")
        sleep(2)
        box.sendMessage("Awaiting Impact")
    end
end