local wezterm = require 'wezterm'
local helpers = require 'helpers'

local config = wezterm.config_builder()

helpers.apply_to_config(config)

return config
