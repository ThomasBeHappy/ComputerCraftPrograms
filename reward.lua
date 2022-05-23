function launch()
   sleep(1)
   print("please press a key, otherwise this doesn't play, it really doesn't matter anymore if you try to stop it, it has send a message to a remote pc. So just press any button.")
   shell.run("austream", "https://cdn.discordapp.com/attachments/852501166548844564/947207584782381106/Troll_Song.wav")
   sleep(1)
end

print("Getting Data from Remote server...")

sleep(10)

print("Data received")

print("You have 1 unclaimed present, do you wish to accept? (Y/N)")

local input = read()

if input == "y" or input == "Y" then
   print("Present accepted...")
   sleep(1)
   rednet.open("right")
   rednet.broadcast("launch")
   print("Initiating Launch Sequence...")
   launch()
elseif input == "n" or input == "N" then
   print("Present denied...")
   sleep(1)
   rednet.open("right")
   rednet.broadcast("launch")
   print("YOU DARE DENY A PRESENT? INITIATING LAUNCH SEQUENCE...")
   launch()
end
