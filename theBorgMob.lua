local interface = peripheral.wrap("back")

interface.disableAI()
peripheral.find("modem", rednet.open)

local position = vector.new(0,0,0)


function receiveLocation()
    while true do
        local id, message = rednet.receive()
        

        if id == 0 then
            position = vector.new(message.x, message.y, message.z)
        end
    end
end

function follow()
    while true do
        if not position == vector.new(0,0,0) then
            interface.walk(position.x, position.y, position.z)
        end

        sleep(2)
    end
end

parallel.waitForAll(receiveLocation, follow)