
local Transformations = {
    moveTo = "m%s,%s", -- x, y
    lineTo = "l%s,%s", -- x, y
    hLineTo = "h%s", -- x
    vLineTo = "v%s", -- y
    curveTo = "c%s,%s %s,%s %s,%s", -- x1, y1, x2, y2, x, y
    sCurveTo = "s%s,%s %s,%s", -- x2, y2, x, y
    qCurveTo = "q%s,%s %s,%s", -- x1, y1, x, y
    sqCurveTo = "t%s,%s", -- x, y
    archTo = "a%s,%s %s %s,%s %s,%s", -- rx, ry, rotation, largeFlag, sweepFlag, x, y
    close = "z"
}

local Element
function Element(Parent, Indent)
    local Parent = Parent or {}
    local Indent = Indent or 0

    return function(Class, Value)
        local Object = {}
        local Children = {}

        table.insert(Parent, Object)
        
        local new = Element(Children, Indent + 1)

        return setmetatable(Object, {
            __index = function(self, index)
                return (index == "new") and new or rawget(self, index)
            end,
            __newindex = function(self, index, value)
                rawset(self, index:gsub("_", "-"), value)
            end,
            __tostring = function(self)
                local Attributes = {}
                local Descendants = {}

                for Attribute, Value in next, Object do
                    table.insert(Attributes, string.format("%s = \"%s\"", Attribute, tostring(Value)))
                end

                if #Children > 0 then
                    for _, Child in next, Children do
                        table.insert(Descendants, tostring(Child))
                    end
                end

                local String = string.format(string.gsub("\t<%s", "\t", string.rep("\t", Indent)), Class)
                String = String .. (#Attributes > 0 and (" " .. table.concat(Attributes, " ")) or "")
                String = String .. ((#Children > 0 or Value) and (Value and string.format(">%s</%s>\n", Value, Class) or string.format(string.gsub(">\n%s\t</%s>\n", "\t", string.rep("\t", Indent)), table.concat(Descendants), Class)) or "/>\n")
                
                return  String
            end
        })
    end
end

return {
    new = function()
        return Element()("svg")
    end,
    path = {
        new = function()
            local Path = {}

            return setmetatable(Path, {
                __index = function(self, Index)
                    return function(self, ...)
                        table.insert(Path, string.format(Transformations[Index], ...))

                        return Index == "close" and tostring(Path) or Path
                    end
                end,
                __tostring = function()
                    return table.concat(Path)
                end
            })
        end
    }
}
