function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

-- Various settings
local width, height = 430, 240
local fov = 70
local chunkDistance = 4
local player = "Gaming_Frame"

-- Require utils
local folder = shell and fs.getDir(shell.getRunningProgram()) or "CC-Images/3D-Matrix/op"
local cache, env = {}, setmetatable({}, { __index = _ENV or getfenv()})
local function require(file)
	local cached = cache[file]
	if cached ~= nil then return cached end

	local func, msg = loadfile(fs.combine(folder, file .. ".lua"), env)
	if not func then error(msg, 2) end

	cached = func()
	cache[file] = cached
	return cached
end
env.require = require

-- Setup example script
local exampleFolder = fs.combine(folder, "examples")

local example = ... and fs.combine(exampleFolder, (...))
if not example or not fs.exists(example) then
	printError("Example not found: choose one of")
	for _, v in ipairs(fs.list(exampleFolder)) do
		print("  " .. v)
	end
	error()
end

local script, err = loadfile(example, env)
if not script then error(err, 0) end

-- Get peripheral/player
local glasses = assert(peripheral.find("arController"), "Cannot find glasses")
local sensor = assert(peripheral.find("playerDetector"), "Cannot find sensor")
print(dump(sensor.getPlayerPos("Gaming_Frame")))
local player = sensor.getPlayerPos("Gaming_Frame") or error("Cannot find " .. player)

-- Load libraries
local matrix = require "matrix"
local transform = require "transform"

local projection = transform.perspective(math.rad(fov), width / height, 0.05, chunkDistance * 16 * 2)
local rotX, rotY = 0, 0
local x, y, z = 0, 0, 8

local graphics = require "graphics"(glasses, width, height)
local offset = { x = 0.5, y = 0.5, z = 0.5 }

local run = script(graphics, glasses)

xpcall(function()
	while true do
		local pData = sensor.getPlayerPos("Gaming_Frame")
		rotX = math.rad(pData.pitch)
		rotY = math.rad(pData.yaw)

		x = offset.x - pData.x
		y = offset.y - pData.y - 1.7
		z = offset.z - pData.z

		local view = matrix.compose(
			transform.rotateX(-rotX),
			transform.rotateY(-rotY),
			transform.translate(-x, -y, -z)
		)

		local mvp = matrix.compose(projection, view)

		glasses.clear()
		run(mvp, pData, x, y, z)

		os.queueEvent("wait")
		os.pullEvent("wait")
	end
end, function(err)
	printError(err)
	for i = 3, 20 do
		local _, msg = pcall(error, "", i)
		if not msg or msg == "" or msg:find("^xpcall:") or msg:find("^nil:") then break end
		print("  " .. msg)
	end
end)

glasses.clear()
