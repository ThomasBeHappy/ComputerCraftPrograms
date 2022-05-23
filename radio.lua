local radio = {
    {"evangeline - matthew sweet", "http://labrosa.ee.columbia.edu/sounds/music/evangeline-matthew_sweet.wav"}, 
    {"i ran so far away - flock of seagulls", "https://www.ee.columbia.edu/~dpwe/sounds/music/i_ran_so_far_away-flock_of_seagulls.wav"}, 
    {"Mick Gordon - The only thing they fear is you", "https://cdn.discordapp.com/attachments/758402526978113566/947958873820635197/Doom_Eternal_OST_-_The_Only_Thing_they_Fear_is_You_Mick_Gordon_2.wav"},
    {"Sabaton - Bismarck","https://cdn.discordapp.com/attachments/758402526978113566/947960641791086634/SABATON_-_Bismarck_Official_Music_Video.wav"}}
local box = peripheral.find("chatBox")

if box == nil then error("Can't find Chat Box") end

while true do
    for i = 1, table.getn(radio), 1 do
        box.sendMessageToPlayer("Now playing: " .. radio[i][1], "Gaming_Frame", "Radio")
        shell.run("austream", radio[i][2])
    end
end
