local modules = peripheral.find("neuralInterface")

if not modules then error("Must have a neural interface", 0) end
if not modules.hasModule("plethora:introspection") then error("Must have an introspection module", 0) end
if not modules.hasModule("plethora:kinetic", 0) then error("Must have a kinetic agument", 0) end
if not modules.hasModule("plethora:sensor", 0) then error("Must have a sensor agument", 0) end

peripheral.find("modem", rednet.open)


while true do
    local data = {id = modules.getID(), name = modules.getName(), inventory = modules.getInventory(), equipment = modules.getEquipment(), player = modules.getMetaOwner() }

    rednet.send(3, data)
    sleep(1)
end