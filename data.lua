local util = require("__unused-renders-m__/util")
unused_renders_m = {
    mipped_item_path_folder  = "__unused-renders-m__/item/mipped/",
    mipped_fluid_path_folder = "__unused-renders-m__/fluid/mipped/",
    tech_icon_path_folder    = "__unused-renders-m__/tech-icon/",
    mipped_item_paths  = require("__unused-renders-m__/item/mipped/image_data_paths"),
    mipped_fluid_paths = require("__unused-renders-m__/fluid/mipped/image_data_paths"),
    tech_icon_paths    = require("__unused-renders-m__/tech-icon/image_data_paths"),
    items_data_path = require("__unused-renders-m__/items_data_path"),
}

--- WARNING: use pairs only if you're looking for created prototypes,
---          but keys could lead to the same prototype and it doesn't
---          mean they exist in data.raw.
---          In other cases use unused_renders_m.items_data_path etc.
---
--- Also, please, add item prototypes into unused_renders_m.prototypes[key]
--- and read its existing keys, if you added them by other methods.
--- It helps to improve mod compatibility.
unused_renders_m.prototypes = {
	--- Please, read unused_renders_m.prototyp
	---@type table<string, data.ItemPrototype>
	items = {},
	--- Please, read unused_renders_m.prototyp
	---@type table<string, data.FluidPrototype>
	fluids = {},
	--- Please, read unused_renders_m.prototypes
	---@type table<string, data.EntityPrototype>
	entities = {},
	--- Please, read unused_renders_m.prototypes
	---@type table<string, data.RecipePrototype>
	recipe = {},
}


--[[
unused_renders_m.correct_file_path(path: string|data.FileName): string|data.FileName
unused_renders_m.get_image_as_sprite(path: string|data.FileName, scale: double?, data: table|data.Sprite?): data.Sprite
unused_renders_m.get_icon_size(path: string|data.FileName): integer
unused_renders_m.set_icon_data(data.PrototypeBase|table, path: string|data.FileName)
unused_renders_m.get_recommended_item_scale(path: string|data.FileName|data.SpriteSource): double?
]]--


unused_renders_m.correct_file_path   = util.correct_file_path
unused_renders_m.get_image_as_sprite = util.get_image_as_sprite
unused_renders_m.get_icon_size       = util.get_icon_size
unused_renders_m.set_icon_data       = util.set_icon_data


unused_renders_m.prototypes.items = setmetatable(unused_renders_m.prototypes.items, {
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


-- Tracks items to find matched items with this mod by name
if lazyAPI then
    lazyAPI.add_listener("on_new_prototype", "all", "unused-renders-m_check_new_prototype", function(event)
        local prototype = event.prototype
        if not lazyAPI.all_items[prototype.type] then return end

        local name = prototype.name
        local is_matched_item = unused_renders_m.items_data_path[name]
        if is_matched_item then
            unused_renders_m.items[name] = prototype
        end
    end)
end


--- Examples
--[[
local item = unused_renders_m.prototypes.items["yellowcake"]
if lazyAPI then
	lazyAPI.add_prototype(item)
else
	data:extend({item}})
end


--- OR


local item = {
	type = "item",
	name = "fluoride",
	icon = "__unused-renders-m__/item/mipped/material-crystal-fluorite-2.png",
	icon_size = icon_size,
	subgroup = "raw-material",
	order = "g[fluoride]",
	stack_size = 50,
	pictures = {
		unused_renders_m.get_image_as_sprite("item/mipped/material-crystal-fluorite-2.png")
	},
}

if lazyAPI then
	lazyAPI.add_prototype(item)
else
	data:extend({item}})
	unused_renders_m.prototypes.items[item.name] = item
end
]]


--- For tests
--[[
for name in pairs(unused_renders_m.items_data_path) do
    if lazyAPI then
        lazyAPI.add_prototype(unused_renders_m.prototypes.items[name])
    else
        data:extend({unused_renders_m.prototypes.items[name]})
    end
end
]]--
