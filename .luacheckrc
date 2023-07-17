unused_args = false
allow_defined_top = true
max_line_length = false

globals = {
    "minetest", "cannons"
}

read_globals = {
    string = {fields = {"split", "trim"}},
    table = {fields = {"copy", "getn"}},

    "default", "ItemStack", "locks", "Settings"
}
