local util = require("__unused-renders-m__/util")


---@type data.ItemPrototype
local item = {
    type = "item",
    name = "fluoride-crystal",
    subgroup = "raw-material", -- TODO: recheck
    order = "g[fluoride-crystal]", -- It'll be improved at some point
    pictures = {
        util.get_image_as_sprite("__unused-renders-m__/item/mipped/material-crystal-fluorite-2.png", 0.5)
    },
    stack_size = 50,
}

util.set_icon_data(item, "__unused-renders-m__/item/mipped/material-crystal-fluorite-2.png")


return item
