local wezterm = require 'wezterm'

local module = {}

local act = wezterm.action

function module.apply_to_config(config)
    config.leader = {
        key = 'Space',
        mods = 'CTRL',
        timeout_milliseconds = 1000
    }

    -- https://wezterm.org/config/lua/general.html
    config.keys = {
        {key = "k", mods = "CMD|SHIFT", action = wezterm.action.ClearScrollback("ScrollbackAndViewport")},
        {
            mods = "LEADER",
            key = "-",
            action = act.SplitPane {
                direction = "Down",
                size = { Percent = 25 },
            }
        },
        {
            mods = "LEADER",
            key = "=",
            action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
        },
        {
            mods = 'LEADER',
            key = 'm',
            action = act.TogglePaneZoomState
        },
        {
            mods = "LEADER",
            key = "Space",
            action = act.RotatePanes "Clockwise"
        },
        {
            mods = 'LEADER',
            key = '0',
            action = act.PaneSelect {
                mode = 'Activate',
            },
        },
    }
end

return module
