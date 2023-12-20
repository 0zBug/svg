documentation coming soon™️

```lua
local svg = require("svg")
local Drawing = svg.new()

local Definitions = Drawing.new("defs")

local Gradient = Definitions.new("linearGradient")
Gradient.id = "Gradient1"

local Stop = Gradient.new("stop")
Stop.stop_color = "white"
Stop.offset = "5%"

local Stop = Gradient.new("stop")
Stop.stop_color = "blue"
Stop.offset = "95%"

local Gradient = Definitions.new("linearGradient")
Gradient.id = "Gradient2"

local Stop = Gradient.new("stop")
Stop.stop_color = "red"
Stop.offset = "5%"

local Stop = Gradient.new("stop")
Stop.stop_color = "orange"
Stop.offset = "95%"

local Pattern = Definitions.new("pattern")
Pattern.id = "Pattern"
Pattern.x = 0
Pattern.y = 0
Pattern.width = 0.25
Pattern.height = 0.25

local Rect = Pattern.new("rect")
Rect.x = 0
Rect.y = 0
Rect.width = 25
Rect.height = 25
Rect.fill = "url(#Gradient2)"

local Circle = Pattern.new("circle")
Circle.cx = 25
Circle.cy = 25
Circle.r = 20
Circle.fill = "url(#Gradient1)"
Circle.fill_opacity = 0.5

local Rect = Drawing.new("rect")
Rect.width = 200
Rect.height = 200
Rect.fill = "url(#Pattern)"

writefile("pattern.svg", Drawing)
```

![result](https://raw.githubusercontent.com/0zBug/svg/main/pattern.svg)
