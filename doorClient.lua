while true do
    os.pullEvent("redstone") -- wait for a "redstone" event

    local data = {id = os.getComputerID(), front = rs.getInput("front"), back = rs.getInput("back")}

    rednet.send(9, data)
end