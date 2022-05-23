os.loadAPI("crypt")

local function getCredits(driveLocation)
    local file = fs.open(driveLocation .. "/data.cas", "r")
    local s = file.readLine()
    file.close();

    local dechipered = crypt.decode(s)

    return dechipered
end

while true do
    while true do

        term.clear()

        print("Welcome to Frame's Casino User Console.")

        print("Please insert a disk.")

        local _, side = os.pullEvent("disk")

        if disk.hasData("bottom") == false then break end

        local driveLocation = disk.getMountPath("bottom")

        print("Disk drive detected and mounted.")
        print("")
        print("1 - Get Credits")
    
        local input = read()
    
        if tonumber(input) == 1 then
            local credits = getCredits(driveLocation)
            print("You have: " .. credits .. " credits on your card.")
            sleep(5)
            break
        end
    end
end
