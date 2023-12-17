
local Element
function Element(Parent, Indent)
    return function(Class)
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
                    table.insert(Attributes, string.format("%s = \"%s\"", Attribute, Value))
                end

                if #Children > 0 then
                    for _, Child in next, Children do
                        table.insert(Descendants, tostring(Child))
                    end
                end

                local String = string.format(string.gsub("\t<%s", "\t", string.rep("\t", Indent)), Class)
                String = String .. (#Attributes > 0 and (" " .. table.concat(Attributes, " ")) or "")
                String = String .. (#Children > 0 and string.format(string.gsub(">\n%s\t</%s>\n", "\t", string.rep("\t", Indent)), table.concat(Descendants), Class) or "/>\n")
                
                return  String
            end
        })
    end
end

return {
    new = function()
        local svg = {}

        return setmetatable({
            new = Element(svg, 1)
        }, {
            __tostring = function()
                local Objects = {}

                for _, Object in next, svg do
                    table.insert(Objects, tostring(Object))
                end

                return string.format("<svg>\n%s</svg>", table.concat(Objects))
            end
        })
    end
}
