os.loadAPI("crypt")

local bet

local function checknumber(num)
    if type(num) == "number" then
        return true
    else
        return false
    end
end

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
    disk.setLabel("bottom", "$" .. creditsS)
end

local function hit(playerValue) 
    local cardValue = math.random(11)

    if cardValue == 1 or cardValue == 11 then
        cardValue = math.random(11)
        if cardValue == 1 or cardValue == 11 then
            cardValue = math.random(11)
        end
    end

    if playerValue + cardValue > 16 and playerValue + cardValue < 22 then
        cardValue = math.random(11)
    end

    if cardValue == 11 then
        if playerValue + cardValue > 21 then
            cardValue = 1
        end
    end

    playerValue = playerValue + cardValue

    print("Card is " .. cardValue)
    print("Player up to: " .. playerValue)
    print("")
    sleep(2)

    return playerValue
end

local function win()
    print("Player wins.")
    print("Original Bet: " .. bet)
    print("Cashout: " .. bet * 2)

    if disk.hasData("bottom") == false then return end

    local playerCredits = getCredits(disk.getMountPath("bottom"))

    setCredits(playerCredits + (bet * 2), disk.getMountPath("bottom"))

    print("Player credits now at: " .. playerCredits + (bet * 2))
    sleep(5)
end

function draw()
    print("It's a draw.")
    print("Original Bet: " .. bet)
    print("Cashout: " .. bet)

    if disk.hasData("bottom") == false then return end

    local playerCredits = getCredits(disk.getMountPath("bottom"))

    setCredits(playerCredits + bet, disk.getMountPath("bottom"))

    print("Player credits now at: " .. playerCredits + bet)
    sleep(5)
end

local function loss()
    print("Dealer wins.")
    print("Original Bet: " .. bet)

    if disk.hasData("bottom") == false then return end

    print("Player credits now at: " .. getCredits(disk.getMountPath("bottom")))
    sleep(5)
end

local function play()
    while true do
        while true do
            term.clear()

            if disk.hasData("bottom") == false then return end

            print("Please enter your bet (500 minimum)... or Q to quit")
            local input = read()

            if input == "Q" or input == "q" then
                disk.eject("bottom")
                return
            end

            local number = tonumber(input)
    
            if checknumber(number) == false then 
                print("Invalid Value.")
                sleep(3)
                break
            end

            if number < 500 then
                print("500 Minimum.")
                sleep(3)
                break
            end

            bet = number

            local playerCredits = getCredits(disk.getMountPath("bottom"))

            if bet > tonumber(playerCredits) then
                print("Not enough balance.")
                sleep(3)
                break
            end

            setCredits(playerCredits - bet, disk.getMountPath("bottom"))

            local playerValue = 0
            local dealerValue = 0

            for i = 1, 2, 1 do
                local cardValue = math.random(11)

                if playerValue + cardValue > 21 then
                    cardValue = 1
                end

                if cardValue == 1 and playerValue + 11 < 22 then
                    cardValue = 11
                end

                playerValue = playerValue + cardValue

                print("Card " .. i .. " is " .. cardValue)
                print("Player up to: " .. playerValue)
                print("")
                sleep(2)
            end

            local cardValue = math.random(5, 11)

            if cardValue == 1 then
                cardValue = 11
            end

            print("Dealer Card 1 is " .. cardValue)

            dealerValue = dealerValue + cardValue

            local dealerCardTwo = math.random(11)

            if dealerCardTwo + dealerValue > 21 then
                dealerCardTwo = 1
            end

            if dealerCardTwo == 1 and dealerValue + 11 < 22 then
                dealerCardTwo = 11
            end

            dealerValue = dealerCardTwo + dealerValue

            print("")
            print("")
            local input

            sleep(2)

            while true do
                print("You: " .. playerValue)
                print("Dealer: " .. dealerValue - dealerCardTwo)
                print("1 - Hit")
                print("2 - Stand")

                input = tonumber(read())
    
                if checknumber(input) == true then 
                    if input == 1 then
                        playerValue = hit(playerValue)

                        if playerValue >= 21 then
                            break
                        end

                    elseif input == 2 then
                        break
                    end
                else 
                    print("Invalid Value.")
                end
            end

            if playerValue > 21 then
                loss()
                break
            else 
                print("Dealer Card 2 is " .. dealerCardTwo)
                print("Dealer: " .. dealerValue)

                sleep(2)

                while dealerValue < 18 or dealerValue < playerValue-1 do
                    local cardValue = math.random(11)
                    
                    if cardValue == 11 then
                        if dealerValue + cardValue > 21 then
                            cardValue = 1
                        end
                    elseif cardValue == 1 then
                        if dealerValue + cardValue < 22 then
                            cardValue = 11
                        end
                    end

                    print("Dealer Card is " .. cardValue)

                    dealerValue = dealerValue + cardValue
                    print("Dealer is up to: " .. dealerValue)
                    print("")
                    sleep(2)
                    if dealerValue == 21 then
                        break
                    end
                end

                if dealerValue > 21 then
                    win()
                    break
                end

                if dealerValue >= playerValue then
                    if playerValue == 21 then
                        draw()
                        break
                    end
                    loss()
                end
            end
        end
    end
end

while true do
    term.clear()
    print("Welcome to Frame's Casino Blackjack.")

    print("Please insert a disk.")

    local _, side = os.pullEvent("disk")

    if disk.hasData("bottom") == false then break end

    play()
end