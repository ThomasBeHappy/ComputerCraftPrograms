os.loadAPI("crypt")

local function getCredits(driveLocation)
    local file = fs.open(driveLocation .. "/data.cas", "r")
    local s = file.readLine()
    file.close();

    local dechipered = crypt.decode(s)

    return dechipered
end

local function setCredits(credits, driveLocation)
    local creditsS = tostring(credits)
    local s = crypt.encode(creditsS)
    local file = fs.open(driveLocation .. "/data.cas", "w")
    file.writeLine(s)
    file.close();
end

local function addCredits (credits, driveLocation)
    local file = fs.open(driveLocation .. "/data.cas", "r")
    local s = file.readLine()
    file.close();

    local totalCredits = tonumber(crypt.decode(s))

    setCredits(totalCredits + credits, driveLocation)
    

    print("Added " .. credits .. " credits.")
    print("New Balance: " .. getCredits(driveLocation) .. " credits.")
end

local function addDiamond(diamonds, driveLocation)

    local file = fs.open(driveLocation .. "/data.cas", "r")
    local s = file.readLine()
    file.close();

    local totalCredits = tonumber(crypt.decode(s))

    local credits = diamonds * 1000

    setCredits(totalCredits + credits, driveLocation)

    print("Added " .. credits .. " credits.")
    print("New Balance: " .. getCredits(driveLocation) .. " credits.")
end

local function removeCredits (credits, driveLocation)
    local file = fs.open(driveLocation .. "/data.cas", "r")
    local s = file.readLine()
    file.close();

    local totalCredits = tonumber(crypt.decode(s))

    if totalCredits < credits then
        print("Not enough balance.")
        return
    end

    setCredits(totalCredits - credits, driveLocation)
    print("Removed " .. credits .. " credits.")
    print("Remaining Balance: " .. getCredits(driveLocation) .. " credits.")
end

local function cashOutDiamonds(diamonds, driveLocation)
    local file = fs.open(driveLocation .. "/data.cas", "r")
    local s = file.readLine()
    file.close();
    local dechipered = crypt.decode(s)

    local totalCredits = tonumber(dechipered)

    if totalCredits < diamonds * 1000 then
        print("Not enough balance.")
        return
    end

    setCredits(totalCredits - (diamonds * 1000), driveLocation)
    print("Hand out " .. diamonds .. " diamonds to the user.")
    print("Remaining Balance: " .. getCredits(driveLocation) .. " credits.")

end

local function checknumber(num, driveLocation)
    if type(num) == "number" then
        return true
    else
        return false
    end
end

local c_tbl =
{
  ["1"] = addCredits,
  ["2"] = addDiamond,
  ["3"] = cashOutDiamonds,
  ["4"] = removeCredits,
  ["5"] = getCredits,
}

while true do
    while true do

        term.clear()

        print("Welcome to Frame's Casino Management Console.")

        print("Please insert a disk.")

        local _, side = os.pullEvent("disk")

        if disk.hasData("bottom") == false then break end

        local driveLocation = disk.getMountPath("bottom")

        
        if fs.exists(driveLocation .. "/data.cas") == false then
            setCredits(0, driveLocation)
        end

        print("Disk drive detected and mounted.")
        print("")
        print("1 - Add Credits")
        print("2 - Add Diamonds")
        print("3 - Cash Out Diamonds")
        print("4 - Remove Credits")
        print("5 - Get Credits")
    
        local input = read()
    
        local func = c_tbl[input]
    
        if(func) then

            if tonumber(input) == 5 then
                local credits = func(driveLocation)
                print("This drive has: " .. credits .. " credits on their card.")
                sleep(2)
                break
            end

            print("Please enter an ammount.")
    
            local amount = tonumber(read())
    
            if checknumber(amount) == false then 
                print("Invalid value.") 
                break
            end
            func(amount, driveLocation)
            disk.setLabel("bottom", "$" .. getCredits(driveLocation))
            sleep(2)
        else
    
        end
    end
end
