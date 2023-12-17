```lua
local Drawing = svg.new()
local Line = Drawing.new("line")
Line.x1 = 0
Line.y1 = 0
Line.x2 = 100
Line.y2 = 100
Line.style = "stroke:blue;stroke-width:5"

writefile("test.svg", Drawing)
```

![](https://raw.githubusercontent.com/0zBug/svg/main/test2.svg)
