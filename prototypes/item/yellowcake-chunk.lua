local util = require("__unused-renders-m__/util")


---@type data.ItemPrototype
local item = {
    type = "item",
    name = "yellowcake-chunk",
    subgroup = 'raw-material', -- TODO: recheck
    order = 'g[uranium-powder-yellowcake-chunk]',
    pictures = {
        util.get_image_as_sprite("__unused-renders-m__/item/mipped/pile-chunk-yellowcake-4.png")
    },
    stack_size = 100
}

util.set_icon_data(item, "__unused-renders-m__/item/mipped/pile-chunk-yellowcake-4.png")


return item
