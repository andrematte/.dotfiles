local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  updates = true,
  icon = {
    font = {
      family = "Hack Nerd Font",
      style = settings.font.style_map["Bold"],
      size = 17.0
    },
    color = colors.white,
    padding_left = 4,
    padding_right = 4,
    background = { image = { corner_radius = 9 } },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 17.0
    },
    color = colors.white,
    padding_left = 4,
    padding_right = 4,
  },
  background = {
    height = 25,
    corner_radius = 5,
    border_width = 0,
    border_color = colors.workspace_border,
    image = {
      corner_radius = 9,
      border_color = colors.grey,
      border_width = 1
    }
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = colors.popup.border,
      color = colors.popup.bg,
      shadow = { drawing = true },
    },
    blur_radius = 50,
  },
  padding_left = 5,
  padding_right = 5,
  scroll_texts = true,
})
