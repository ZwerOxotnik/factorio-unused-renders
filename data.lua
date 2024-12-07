local util = require("__unused-renders-m__/util")
unused_renders_m = {
    mipped_item_path_folder  = "__unused-renders-m__/item/mipped/",
    mipped_fluid_path_folder = "__unused-renders-m__/fluid/mipped/",
    tech_icon_path_folder    = "__unused-renders-m__/tech-icon/",
    items_data_path = require("__unused-renders-m__/items_data_path"),
}
unused_renders_m.items_data_path = require("__unused-renders-m__/items_data_path")
 ---@type table<string, data.ItemPrototype>
unused_renders_m.items = {} -- WARNING: use pairs only if you're looking for created prototypes, but keys could lead to the same prototype. In other cases use unused_renders_m.items_data_path


--[[
unused_renders_m.correct_file_path(path: string|data.FileName): string|data.FileName
unused_renders_m.get_image_as_sprite(path: string|data.FileName, scale: double?, data: table|data.Sprite?): data.Sprite
unused_renders_m.get_icon_size(path: string|data.FileName): integer
unused_renders_m.set_icon_data(data.PrototypeBase|table, path: string|data.FileName)
]]--


unused_renders_m.correct_file_path   = util.correct_file_path
unused_renders_m.get_image_as_sprite = util.get_image_as_sprite
unused_renders_m.get_icon_size       = util.get_icon_size
unused_renders_m.set_icon_data       = util.set_icon_data


unused_renders_m.items = setmetatable(unused_renders_m.items, {
    ---@param _k string
    __index = function(self, _k)
        local path = unused_renders_m.items_data_path[_k]
        if path then
            return require(path)
        end

        path = unused_renders_m.correct_file_path(_k)
        return require(path)
    end
})


--- Examples
--[[
    data:extend({unused_renders_m.items["yellowcake"]})

    data:extend({{
        type = "item",
        name = "fluoride",
        icon = "__unused-renders-m__/item/mipped/material-crystal-fluorite-2.png",
        icon_size = icon_size, icon_mipmaps = 4,
        subgroup = "raw-material",
        order = "g[fluoride]",
        stack_size = 50,
        pictures = {
            unused_renders_m.get_image_as_sprite("item/mipped/material-crystal-fluorite-2.png", 0.5),
        }
    }})
]]


--- For tests
--[[
for name in pairs(unused_renders_m.items_data_path) do
    if lazyAPI then
        lazyAPI.add_prototype(items_data_path.items[name])
    else
        data:extend({items_data_path.items[name]})
    end
end
]]--
