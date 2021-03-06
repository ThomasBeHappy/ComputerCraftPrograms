local mon = peripheral.wrap("back")

function lineBreak()
    x, y = mon.getCursorPos()
    if y ~= 1 then
            y = y + 1
    end
    mon.setCursorPos(1, y)
    width, height = mon.getSize()
    mon.write("+" .. string.rep("-", width - 2) .. "+")
end

function printString(sString)
    x, y = mon.getCursorPos()
    y = y + 1
    mon.setCursorPos(1, y)
    mon.write(sString)
end

function printStringCentre(sString)
    x, y = mon.getCursorPos()
    y = y + 1
    mon.setCursorPos(1, y)
    width, height = mon.getSize()
    nStringCentre = math.floor(string.len(sString) / 2) - 1
    nMonitorCentre = math.floor(width / 2)
    x = math.floor(nMonitorCentre - nStringCentre)
    mon.setCursorPos(x, y)
    mon.write(sString)
end

function printStringRight(sString)
width, height = mon.getSize()
x, y = mon.getCursorPos()
y = y + 1
x = math.ceil(width - string.len(sString))
mon.setCursorPos(x, y)
mon.write(sString)
end
function scrollText(tStrings, nRate)
nRate = nRate or 5
if nRate < 0 then
  error("rate must be positive")
end
local nSleep = 1 / nRate

width, height = mon.getSize()
x, y = mon.getCursorPos()
    sText = ""
    for n = 1, #tStrings do
            sText = sText .. tostring(tStrings[n])
  sText = sText .. " | "
    end
    sString = "| "
    if width / string.len(sText) < 1 then
            nStringRepeat = 3
    else
            nStringRepeat = math.ceil(width / string.len(sText) * 3)
    end
for n = 1, nStringRepeat do
  sString = sString .. sText
end
while true do
  for n = 1, string.len(sText) do
   sDisplay = string.sub(sString, n, n + width - 1)
   mon.clearLine()
   mon.setCursorPos(1, y)
   mon.write(sDisplay)
   sleep(nSleep)
  end
end
end
mon.clear()
mon.setCursorPos(1, 1)
lineBreak()
printStringCentre("|Black Jack|")
lineBreak()
printString("")
lineBreak()
tScrollText = {}
tScrollText[1] = "Beat the dealer!"
tScrollText[2] = "Win up to double your credits!"
x, y = mon.getCursorPos()
y = y - 1
mon.setCursorPos(1, y)
scrollText(tScrollText, 4)