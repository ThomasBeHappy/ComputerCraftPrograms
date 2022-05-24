local interface = peripheral.wrap("back")

interface.disableAI()
peripheral.find("modem", rednet.open)

local position = {}


function receiveLocation()
    while true do
        local id, message = rednet.receive()

        print(message.x)

        position.x = message.x
        position.y = message.y
        position.z = message.z
    end
end

function follow()
    while true do
        if not position == {} then
            interface.walk(position.x, position.y, position.z)
        end

        sleep(2)
    end
end

parallel.waitForAll(receiveLocation, follow)