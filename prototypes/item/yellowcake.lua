local util = require("__unused-renders-m__/util")


---@type data.ItemPrototype
local item = {
    type = "item",
    name = "yellowcake",
    subgroup = 'raw-material',
    order = 'g[uranium-powder-yellowcake]',
    pictures = {
        util.get_image_as_sprite("__unused-renders-m__/item/mipped/pile-dust-yellowcake-1.png", 0.4),
        util.get_image_as_sprite("__unused-renders-m__/item/mipped/pile-dust-yellowcake-2.png", 0.4),
        util.get_image_as_sprite("__unused-renders-m__/item/mipped/pile-dust-yellowcake-3.png", 0.4),
    },
    stack_size = 100
}

util.set_icon_data(item, "__unused-renders-m__/item/mipped/pile-dust-yellowcake-1.png")


return item
