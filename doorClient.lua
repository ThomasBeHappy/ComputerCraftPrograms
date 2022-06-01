rednet.open("top")

local function redstone()
    while true do
        os.pullEvent("redstone") -- wait for a "redstone" event
    
        local data = {id = os.getComputerID(), doors = {rs.getInput("front"), rs.getInput("back")}}
    
        rednet.send(9, data)
        
        sleep(1)
    end
end

local function ping()
    while true do
        local id, message = rednet.receive()

        if message == "DOORSERVER_PING" then
            local data = {id = os.getComputerID(), doors = {rs.getInput("front"), rs.getInput("back")}}
    
            rednet.send(9, data)
        end
    end
end

parallel.waitForAll(ping, redstone)