local icons = require("icons")
local settings = require("settings")

local caffeinate_icons = icons.caffeinate or { on = icons.switch.on, off = icons.switch.off }
local query_assertions = [[pmset -g assertions | grep "caffeinate" | awk '{print $2}' | cut -d '(' -f1 | head -n 1]]

local caffeinate = sbar.add("item", "caffeinate", {
  position = "right",
  update_freq = 30,
  padding_left = 0,
  padding_right = 0,
  icon = {
    string = caffeinate_icons.off,
    font = {
      family = "Hack Nerd Font",
      style = settings.font.style_map["Bold"],
      size = 17,
    },
  },
  label = { drawing = false },
})

local function set_icon(pid)
  local active = pid and pid ~= ""
  caffeinate:set({
    icon = { string = active and caffeinate_icons.on or caffeinate_icons.off },
  })
end

local function refresh()
  sbar.exec(query_assertions, function(result)
    local pid = result:match("(%d+)")
    set_icon(pid)
  end)
end

local function toggle()
  sbar.exec(query_assertions, function(result)
    local pid = result:match("(%d+)")
    if pid then
      sbar.exec("kill -9 " .. pid, refresh)
    else
      sbar.exec("caffeinate -id >/dev/null 2>&1 &", refresh)
    end
  end)
end

caffeinate:subscribe("mouse.clicked", toggle)
caffeinate:subscribe({ "routine", "system_woke" }, refresh)

refresh()
