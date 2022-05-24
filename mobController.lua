peripheral.find("modem", rednet.open)

if not modules.hasModule("plethora:introspection") then error("Must have an introspection module", 0) end
if not modules.hasModule("plethora:sensor", 0) then error("Must have a sensor agument", 0) end


while true do
    rednet.broadcast({x = modules.getMetaOwner().x, y = modules.getMetaOwner().y, z = modules.getMetaOwner().z})
    sleep(1)
end