return {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
        stiffness = 0.8,
        trailing_stiffness = 0.8,
        matrix_pixel_threshold = 0.5,
        distance_stop_animating = 0.5,
        time_interval = 8, -- 17ms default caps at ~60fps; ProMotion does 120
        -- guicursor is unset, so Ghostty's block cursor applies in every mode
        vertical_bar_cursor_insert_mode = false,
    },
}
