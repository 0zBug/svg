local svg = require("svg")
local Drawing = svg.new()

local Definitions = Drawing.new("defs")

local Gradient = Definitions.new("linearGradient")
Gradient.id = "Gradient"

local Stop = Gradient.new("stop")
Stop.stop_color = "red"
Stop.offset = "0%"

local Stop = Gradient.new("stop")
Stop.stop_color = "black"
Stop.offset = "50%"

local Stop = Gradient.new("stop")
Stop.stop_color = "blue"
Stop.offset = "100%"

local Rect = Drawing.new("rect")
Rect.x = 1
Rect.y = 1
Rect.width = 100
Rect.height = 100
Rect.fill = "url(#Gradient)"
