require('on')
local config = {
    font = require('wezterm').font('FiraCode Nerd Font'),
    default_prog = require('utils').system() and { 'pwsh', '-nol' } or nil,
    keys = require('keys'),
    key_tables = require('keys_mode'),
    launch_menu = require('utils').launch_menu,
}
require('utils').translate_toml_to_lua(config)
return config
