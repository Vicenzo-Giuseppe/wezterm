local wezterm = require 'wezterm'
local config_dir = wezterm.config_dir
package.path = config_dir .. "/?.lua"
require('on')
local config = {
    font = require('wezterm').font('FiraCode Nerd Font'),
    default_prog = require('utils').system() and { 'pwsh', '-nol' } or nil,
    keys = require('keys'),
    key_tables = require('keys_mode'),
    launch_menu = require('utils').launch_menu,
    colors = wezterm.color.load_scheme(config_dir .. "/colors/catppuccin.toml"), -- in /nix/store cant generate colors from folder

}
require('utils').translate_toml_to_lua(config)
return config
