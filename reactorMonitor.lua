local monitor = peripheral.wrap("right")
monitor.clear()
monitor.setCursorPos(1,1)

local function write(input, x, y)
    local curX, curY = monitor.getCursorPos()
    curX = x or curX
    curY = y or curY 
    
    monitor.setCursorPos(curX, curY)
    monitor.write(input)
end

local function monitorUpdate()
    while true do

        monitor.clear()

        rednet.send(18, "getInfo")
        local id, message = rednet.receive(nil, 5)
        if not id then
            error("No data received")
        end

        local status

        if message.reactorStatus then
            status = "ACTIVE"
        else 
            status = "OFFLINE"
        end

        write("Reactor Status: " .. status, 1, 1)
        write("Turbine Energy Percent: " .. math.floor((message.currentEnergy / message.maxEnergy * 100) *100) / 100 .. "%" , 1, 2)
        write("Temperature: " .. message.reactorTemperature .. "K" , 1, 3)
        write("Fuel Percent: " .. math.floor((message.reactorFuel.amount / message.reactorFuelCapacity * 100) *100) / 100 .. "%", 1, 4)
        write("Coolant Percent: " .. math.floor((message.reactorCoolant.amount / message.reactorCoolantCapacity * 100) *100) / 100 .. "%", 1, 5)
        write("Production: " .. message.energyProduction / 2.5 .. " FE/t", 1, 6)
        
        sleep(1)
    end
end

local function terminal()
    local sheets = dofile "lib.lua"

    rednet.open("top")

    local application = sheets.Application()

    local start = application.screen + sheets.Button( 0, 0, 20, 5, "Activate Reactor" )
    local scram = application.screen + sheets.Button( 25, 0, 20, 5, "SCRAM" )
    local reset = application.screen + sheets.Button( 25, 10, 20, 5, "Reset Warnings" )

    function start:onClick()
        rednet.send(18, "start")
    end

    function scram:onClick()
        rednet.send(18, "scram")
    end

    function reset:onClick()
        rednet.send(18, "resetWarnings")
    end

    application:run()
end

parallel.waitForAny(terminal, monitorUpdate)