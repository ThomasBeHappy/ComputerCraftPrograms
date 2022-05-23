local box = peripheral.find("chatBox")

if box == nil then error("chatBox not found") end

redstone.setOutput("bottom", true)

while true do
    event, username, message = os.pullEvent("chat") -- Will be fired when someone sends a chat message
    if (username == "Gaming_Frame" or username == "DerpLvlAsian") and message == ".open" then
        redstone.setOutput("bottom", false)
        sleep(1)
        redstone.setOutput("bottom", true)
    end
  end