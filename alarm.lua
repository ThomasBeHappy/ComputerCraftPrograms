local detector = peripheral.find("playerDetector")
local box = peripheral.find("chatBox")
local DiscordHook = require("DiscordHook")

local success, hook = DiscordHook.createWebhook("https://discord.com/api/webhooks/946876894207434833/iD1SqtTiH0XRcVlxi8YS6HJmxuNJh4j-8zH0qYWRtVMCs7QthHCVVuGTwek4ymvkVH-p")


if detector == nil then error("playerDetector not found") end
if box == nil then error("chatBox not found") end

if not success then
    error("Webhook connection failed! Reason: " .. hook)
end

function checkArea(range)
    local players = detector.getPlayersInRange(range) --Returns a table of every player in a certain range
    for k,v in pairs(players) do --we use a for loop to print the names of every player
        if v ~= "Gaming_Frame" and v ~= "GhostAjay" then
            -- WARNING ENEMY ENTERED
            hook.sendEmbed("@everyone", "Base Defense System", "An intruder has been detected! User **'" .. v .. "'** has entered our territory!", nil, 0xFF0000, nil, "https://media.energetic.pw/pm5s32-c9z.png", "Base Defence System", "https://media.energetic.pw/pm5sfo-82l.jpg")
            box.sendMessageToPlayer("WARNING: " .. v .. " HAS ENTERED TERRITORY!", "Gaming_Frame")
            sleep(1)
            box.sendMessageToPlayer("WARNING: " .. v .. " HAS ENTERED TERRITORY!", "GhostAjay")
            sleep(1)
            box.sendMessageToPlayer("You start hearing boss music.", v)
            shell.run("austream", "https://cdn.discordapp.com/attachments/852501166548844564/946865060926607441/Undertale_-_Megalovania.wav")
            return
        end
    end
end

hook.sendEmbed("", "Base Defense System", "Base Warning System is operational.", nil, 0xFFF000, nil, "https://media.energetic.pw/pm5s32-c9z.png", "Base Defence System", "https://media.energetic.pw/pm5sfo-82l.jpg")

while true do
checkArea(100)
end