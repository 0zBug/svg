return {
    new = function()
        local svg = {}

        return setmetatable({
            new = function(Class)
                local Object = {}

                table.insert(svg, Object)

                return setmetatable(Object, {
                    __tostring = function(self)
                        local Attributes = {}

                        for Attribute, Value in next, Object do
                            table.insert(Attributes, string.format("%s = \"%s\"", Attribute, Value))
                        end

                        return string.format("<%s %s/>", Class, table.concat(Attributes, " "))
                    end
                })
            end
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
