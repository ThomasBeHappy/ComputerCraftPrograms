local modules = peripheral.find("neuralInterface")
if not modules then
	error("Cannot find neuralInterface", 0)
end

if not modules.hasModule("plethora:laser") then error("Cannot find laser", 0) end
if not modules.hasModule("plethora:sensor") then error("Cannot find entity sensor", 0) end

local function fire(entity)
	local x, y, z = entity.x, entity.y, entity.z
	local pitch = -math.atan2(y, math.sqrt(x * x + z * z))
	local yaw = math.atan2(-x, z)

	modules.fire(math.deg(yaw), math.deg(pitch), 5)
	sleep(0.2)
end

local mobNames = { "Creeper", "Zombie", "Skeleton", "Spider" }
local mobLookup = {}
for i = 1, #mobNames do
	mobLookup[mobNames[i]] = true
end

while true do
	local mobs = modules.sense()
    local candidates = {}
	for i = 1, #mobs do
		local mob = mobs[i]
		if mobLookup[mob.name] then
			candidates[#candidates + 1] = mob
		end
	end
    local candidates = {}
	for i = 1, #mobs do
		local mob = mobs[i]
		if mobLookup[mob.name] then
			candidates[#candidates + 1] = mob
		end
	end
    if #candidates > 0 then
		local mob = candidates[math.random(1, #candidates)]
		fire(mob)
	else
		sleep(1)
	end
end