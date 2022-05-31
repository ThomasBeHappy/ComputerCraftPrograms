monitor = nil

function setMonitor(handle)
    monitor = handle
end

function drawBox(startX, startY, endX, endY, color)

    sizeX = startX - endX
    sizeY = startY - endY

    monitor.setTextColor(color)
    for x = 0, sizeX, 1 do
        for y = 0, sizeY, 1 do
            monitor.setCursorPos(startX + x, startY + y)
            monitor.write()
        end
    end
end