local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  position = "top",
  height = 32,
  color = colors.bar.bg,
  padding_right = 0,
  padding_left = 0,
  y_offset = 0,
  corner_radius = 0,
  margin = 0,
  blur_radius = 30,
})
