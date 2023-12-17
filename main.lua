
local Element
function Element(Parent)
    return function(Class)
        local Object = {}
        local Children = {}

        table.insert(Parent, Object)
        
        local new = Element(Children)

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
                    table.insert(Attributes, string.format("%s = \"%s\"", Attribute, Value))
                end

                for _, Child in next, Children do
                    table.insert(Descendants, tostring(Child))
                end

                return string.format("<%s %s>%s</%s>", Class, table.concat(Attributes, " "), table.concat(Descendants, "\n"), Class)
            end
        })
    end
end

return {
    new = function()
        local svg = {}

        return setmetatable({
            new = Element(svg)
        }, {
            __tostring = function()
                local Objects = {}

                for _, Object in next, svg do
                    table.insert(Objects, tostring(Object))
                end

                return string.format("<svg>\n%s\n</svg>", table.concat(Objects, "\n"))
            end
        })
    end
}
