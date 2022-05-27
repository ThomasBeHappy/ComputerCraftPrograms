os.loadAPI("button.lua")

-- Set monitor loc
local mon = peripheral.wrap("front")
local adminMon = peripheral.wrap("back")
button.setMonitor(adminMon)
-- Set password
local pass = "1234"
local passlen = string.len(pass)
local press = "";
tblpad = {};
for i=0,10 do 
tblpad[i] = {}
	for x=0,10 do
		tblpad[i][x] = "x"
	end
end

rs.setOutput("right", true)

tblpad[2][2] = "1"
tblpad[4][2] = "2"
tblpad[6][2] = "3" 
tblpad[2][3] = "4"
tblpad[4][3] = "5"
tblpad[6][3] = "6" 
tblpad[2][4] = "7"
tblpad[4][4] = "8"
tblpad[6][4] = "9" 
tblpad[4][5] = "0" 

function drawpad()
	mon.setBackgroundColor(colors.green)
	mon.setCursorPos(1,1)
	mon.write(" Code?  ")
	mon.setCursorPos(1,2)
	mon.write(" 1 2 3  ")
	mon.setCursorPos(1,3)
	mon.write(" 4 5 6 ")
	mon.setCursorPos(1,4)
	mon.write(" 7 8 9 ")
	mon.setCursorPos(1,5)
	mon.write("   0   ")
end

function countdown(c)

	for i=1,c do
		mon.setCursorPos(1,1)
		mon.write("       ")
		mon.setCursorPos(1,2)
		mon.write("       ")
		mon.setCursorPos(1,3)
		mon.write("   ".. c .."   ")
		mon.setCursorPos(1,4)
		mon.write("       ")
		mon.setCursorPos(1,5)
		mon.write("       ")
		sleep(1)
		c = c-1 
	end
end

function dots()
	mon.setBackgroundColor(colors.red)
	mon.setCursorPos(1,1)
	mon.write("       ")
	mon.setCursorPos(1,2)
	mon.write("       ")
	mon.setCursorPos(1,3)
	mon.write("  ...  ")
	mon.setCursorPos(1,4)
	mon.write("       ")
	mon.setCursorPos(1,5)
	mon.write("       ")
end


function opendoor()
dots()
	--Open Door Code
    rs.setOutput("right", false)
	countdown(5)
	dots()
    rs.setOutput("right", true)
	--Close Door Code
	drawpad()
end

function wrongpass()
	mon.setBackgroundColor(colors.red)
	mon.setCursorPos(1,1)
	mon.write("       ")
	mon.setCursorPos(1,2)
	mon.write(" Wrong ")
	mon.setCursorPos(1,3)
	mon.write("       ")
	mon.setCursorPos(1,4)
	mon.write(" Code! ")
	mon.setCursorPos(1,5)
	mon.write("       ")
	sleep(2)
	countdown(5)
	drawpad()
end
drawpad()


function keypadSide()
    while true do
        event, side, xPos, yPos = os.pullEvent("monitor_touch")
        if tblpad[xPos][yPos] ~= "x" then
            mon.setCursorPos(xPos, yPos)
            mon.setBackgroundColor(colors.red)
            mon.write(tblpad[xPos][yPos])
            sleep(0.2)
            mon.setCursorPos(xPos, yPos)
            mon.setBackgroundColor(colors.green)
            mon.write(tblpad[xPos][yPos])
            press = press .. tblpad[xPos][yPos]
            if string.len(press) == passlen and press == pass then
                press = ""
                opendoor()
            elseif string.len(press) == passlen and press ~= pass then
                press = ""
                wrongpass()
            end
        end
    end
end


function adminSide()
    myButton = button.create("Open Door")
    width, height = mon.getSize()
    myButton.setPos(width / 2 - 4, height / 2)
    myButton.onClick(opendoor)
    while true do
        button.await(myButton)
    end
end

parallel.waitForAll(keypadSide, admin)