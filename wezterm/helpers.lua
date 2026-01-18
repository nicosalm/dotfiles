local wezterm = require 'wezterm'
local keymaps = require 'keymaps'
local colors = require 'colors'

local module = {}

local function setup_background(config)
    config.background = {
        {
            source = {
                File = wezterm.config_dir .. '/images/background.png',
            },
            width = '100%',
            height = '100%',
            opacity = 0.95,
            hsb = {
                brightness = 0.3,
            },
            attachment = 'Fixed',
        },
    }
end

function module.apply_to_config(config)
    config.window_decorations = 'RESIZE'
    config.font = wezterm.font 'FiraCode Nerd Font'
    config.font_size = 17.0
    config.initial_rows = 40
    config.initial_cols = 100
    config.hide_tab_bar_if_only_one_tab = true

    setup_background(config)
    colors.apply_to_config(config)
    keymaps.apply_to_config(config)
end

return module
