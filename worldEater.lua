local box = peripheral.find("chatBox")

if box == nil then error("chatBox not found") end

while true do
    os.pullEvent("redstone") -- wait for a "redstone" event

    if rs.getInput("front") then
        box.sendMessage("WARNING: THE WORLD EATER HAS BEEN TURNED ON. PREPARE FOR CHAOS.", "World Eater")
        sleep(2)
        box.sendMessage("Estimated time till the end: " .. math.random(4, 7) .. " days", "World Eater")
        return
    end
end
