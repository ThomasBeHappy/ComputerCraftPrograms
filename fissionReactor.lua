local DiscordHook = require("DiscordHook")
local reactor = peripheral.wrap("fissionReactorLogicAdapter_1")
local turbine = peripheral.wrap("turbineValve_0")
local box = peripheral.find("chatBox")

if reactor == nil then error("reactor not found") end
if turbine == nil then error("turbine not found") end
if box == nil then error("chatBox not found") end

local success, hook = DiscordHook.createWebhook("https://discord.com/api/webhooks/977562741797711912/QCsQ0sAwQCkUYL2r8EdFFZW4V06_ymvq4vScyqHs9dxrogYc7d8yzCKQ5AVaifsZ4Fcw")
if not success then
    error("Webhook connection failed! Reason: " .. hook)
end

rednet.open("top")

-- Percent = total / current * 100

box.sendMessage("Initialising Reactor Program...", "Reactor Monitor")

print("Initialising...")

-- Turbine
local currentEnergy
local maxEnergy
local energyPercentage
local energyProduction

-- Reactor
local reactorStatus
local reactorBurnRate
local reactorActualBurnRate
local reactorTemperature
local embedStatus
local reactorCoolant
local reactorCoolantCapacity
local reactorCoolantPercentage
local reactorFuel
local reactorFuelCapacity
local reactorFuelPercentage
local reactorWaste
local reactorWasteCapacity
local reactorWastePercentage

currentEnergy = turbine.getEnergy()
maxEnergy = turbine.getMaxEnergy()
energyPercentage = math.floor((turbine.getEnergy() / turbine.getMaxEnergy() * 100) *100) / 100
energyProduction = turbine.getProductionRate()
reactorStatus = reactor.getStatus();
reactorBurnRate = reactor.getBurnRate()
reactorActualBurnRate = reactor.getActualBurnRate()
reactorTemperature = math.floor(reactor.getTemperature()*100)/100

reactorCoolant = reactor.getCoolant()
reactorCoolantCapacity = reactor.getCoolantCapacity()
reactorCoolantPercentage = reactor.getCoolantFilledPercentage()
reactorFuel = reactor.getFuel()
reactorFuelCapacity = reactor.getFuelCapacity()
reactorFuelPercentage = reactor.getFuelFilledPercentage()
reactorWaste = reactor.getWaste()
reactorWasteCapacity = reactor.getWasteCapacity()
reactorWastePercentage = reactor.getWasteFilledPercentage()


if reactorStatus then
    embedStatus = "ACTIVE"
else 
    embedStatus = "OFFLINE"
end

local fuelWarning = false

local function updateStats()

    while true do
        currentEnergy = turbine.getEnergy()
        maxEnergy = turbine.getMaxEnergy()
        energyPercentage = math.floor((turbine.getEnergy() / turbine.getMaxEnergy() * 100) *100) / 100
        energyProduction = turbine.getProductionRate()
        reactorStatus = reactor.getStatus();
        reactorBurnRate = reactor.getBurnRate()
        reactorActualBurnRate = reactor.getActualBurnRate()
        reactorTemperature = math.floor(reactor.getTemperature()*100)/100
    
        reactorCoolant = reactor.getCoolant()
        reactorCoolantCapacity = reactor.getCoolantCapacity()
        reactorCoolantPercentage = reactor.getCoolantFilledPercentage()
        reactorFuel = reactor.getFuel()
        reactorFuelCapacity = reactor.getFuelCapacity()
        reactorFuelPercentage = reactor.getFuelFilledPercentage()
        reactorWaste = reactor.getWaste()
        reactorWasteCapacity = reactor.getWasteCapacity()
        reactorWastePercentage = reactor.getWasteFilledPercentage()
        

        if reactorStatus then
            embedStatus = "ACTIVE"
        else 
            embedStatus = "OFFLINE"
        end

        sleep(0.5)
    end

    print("NO")
end

local function sendEmbed(embedMessage)
    hook.sendEmbed("<@229563674375749633>", "Fission Reactor Monitor", embedMessage, nil, colours.red, nil, nil, "Fission Reactor Monitor", "https://seeklogo.com/images/A/arc-reactor-logo-E940091674-seeklogo.com.png")
end


local function manageReactor()

    reactor.activate()
    reactor.setBurnRate(7)

    while true do
        if reactorStatus then
            if reactorTemperature > 1000 then
                print("temp")
                reactor.scram()

                box.sendMessage("SCRAM ACTIVATED - REACTOR REACHED CRITICAL LEVELS...", "Reactor Monitor")
                sendEmbed("**TEMPERATURE HAS REACHED CRITICAL LEVELS** \nReactor Status: *" .. embedStatus .. "*\nReactor Temperature: *" ..  reactorTemperature .. "*K\nReactor Burn Rate: *" .. reactorBurnRate .. "* mb/t\nReactor Actual Burn Rate: *" .. reactorActualBurnRate .. "* mb/t")
                reactorStatus = false
            end

            if reactorCoolantPercentage < 0.3 then
                print("cool")
                reactor.scram()

                box.sendMessage("SCRAM ACTIVATED - COOLANT BELOW 30%...", "Reactor Monitor")
                sendEmbed("**COOLANT IS BELOW 30%**")
                reactorStatus = false
            end

            if reactorWastePercentage > 0.9 then
                print("waste")
                reactor.scram()

                box.sendMessage("SCRAM ACTIVATED - Reactor waste is above 90%, please check waste barrels...", "Reactor Monitor")
                sendEmbed("**Waste is above 90%**")
                reactorStatus = false
            end

            if reactorFuelPercentage < 0.1 and not fuelWarning then
                print("fuel")
                box.sendMessage("Reactor is below 10% fuel, please refil the generation...", "Reactor Monitor")
                sendEmbed("**Reactor is below 10% fuel**")
                fuelWarning = true
            end

            if energyPercentage > 90 then
                print("energy")
                reactor.scram()

                box.sendMessage("SCRAM ACTIVATED - Turbine's energy is 90% filled, please use the energy...", "Reactor Monitor")
                sendEmbed("**Turbine is 90% filled with energy**")
                reactorStatus = false
            end       
        end

        -- TODO Manage the burn rate of the reactor

        sleep(0.5)
    end

    print("NO")
end

local function manageServer()
    while true do
        local id, message = rednet.receive()

        if message == "start" then
            if not reactorStatus then
                reactor.activate()
            end
        elseif message == "scram" then
            if reactorStatus then
                reactor.scram()
            end
        elseif message == "resetWarnings" then
            fuelWarning = false
        elseif message == "getInfo" then
            local table = {reactorStatus = reactorStatus, reactorCoolant = reactorCoolant, reactorCoolantCapacity = reactorCoolantCapacity, reactorFuel = reactorFuel, reactorFuelCapacity = reactorFuelCapacity, reactorTemperature = reactorTemperature, currentEnergy = currentEnergy, maxEnergy = maxEnergy, energyProduction = energyProduction}

            rednet.send(id, table)
        end

    end

    print("NO")
end

local function testing()
    if reactorStatus then
        reactorStatus = false
        reactor.scram()
    end

    -- Check if coolant is there and is filled enough before proceeding with test.
    if reactorCoolantPercentage > 0.3 then
        box.sendMessage("Testing - Starting Reactor Test", "Reactor Monitor")

        sleep(2)
        box.sendMessage("SCRAM ACTIVATED - REACTOR REACHED CRITICAL LEVELS...", "Reactor Monitor")
        sendEmbed("**TEMPERATURE HAS REACHED CRITICAL LEVELS** \nReactor Status: *" .. embedStatus .. "*\nReactor Temperature: *" ..  reactorTemperature .. "*K\nReactor Burn Rate: *" .. reactorBurnRate .. "* mb/t\nReactor Actual Burn Rate: *" .. reactorActualBurnRate .. "* mb/t")
        sleep(2)

        box.sendMessage("SCRAM ACTIVATED - COOLANT BELOW 30%...", "Reactor Monitor")
        sendEmbed("**COOLANT IS BELOW 30%**")
        sleep(2)

        box.sendMessage("SCRAM ACTIVATED - Reactor waste is above 90%, please check waste barrels...", "Reactor Monitor")
        sendEmbed("**Waste is above 90%**")
        sleep(2)

        box.sendMessage("Reactor is below 10% fuel, please refil the generation...", "Reactor Monitor")
        sendEmbed("**Reactor is below 10% fuel**")
        sleep(2)

        box.sendMessage("SCRAM ACTIVATED - Turbine's energy is 90% filled, please use the energy...", "Reactor Monitor")
        sendEmbed("**Turbine is 90% filled with energy**")
        sleep(2)
    else 
        box.sendMessage("Testing - Can't proceed with Test, coolant is below 30%", "Reactor Monitor")
    end
    -- Turn reactor on for 2 seconds at 1 mb/t burn rate then turn the reactor back off

    reactor.activate()
    reactor.setBurnRate(1)

    sleep(4)

    reactor.scram()
end


currentEnergy = turbine.getEnergy()
maxEnergy = turbine.getMaxEnergy()

print("Turbine Energy: " .. currentEnergy .. " FE")
print("Turbine Max Energy: " .. maxEnergy .. " FE")

energyPercentage = math.floor((turbine.getEnergy() / turbine.getMaxEnergy() * 100) *100) / 100

print("Turbine Stored Percentage: " .. energyPercentage .. "%")

print("")

reactorStatus = reactor.getStatus();


if reactorStatus then
    print("Reactor Status: ACTIVE")
    embedStatus = "ACTIVE"
else 
    print("Reactor Status: OFFLINE")
    embedStatus = "OFFLINE"
end

reactorBurnRate = reactor.getBurnRate()
reactorActualBurnRate = reactor.getActualBurnRate()
reactorTemperature = math.floor(reactor.getTemperature()*100)/100

print("Reactor Burn Rate: " .. reactorBurnRate .. " mb/t")
print("Reactor Actual Burn Rate: " .. reactorActualBurnRate .. " mb/t")
print("Reactor Temperature: " .. reactorTemperature .. "K")


hook.sendEmbed("<@229563674375749633>", "Fission Reactor Monitor", "**Reactor Monitor Has Initialized** \nReactor Status: *" .. embedStatus .. "*\nReactor Temperature: *" ..  reactorTemperature .. "*K\nReactor Burn Rate: *" .. reactorBurnRate .. "* mb/t\nReactor Actual Burn Rate: *" .. reactorActualBurnRate .. "* mb/t", nil, 0x0FF00, nil, nil, "Fission Reactor Monitor", "https://seeklogo.com/images/A/arc-reactor-logo-E940091674-seeklogo.com.png")

print("Testing Phase")

testing()

print("Test Successfull... Starting Reactor")

box.sendMessage("Testing - Test Successfull, Starting Reactor", "Reactor Monitor")

print(parallel.waitForAny(updateStats, manageReactor, manageServer))

print("FUCK")