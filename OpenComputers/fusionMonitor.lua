local colors = require "colors"
local component = require "component"
local gpu = component.gpu

gpu.setForeground(colors.gray)
gpu.setBackground(colors.orange)

gpu.fill(1, 1, 10, 10, "x")