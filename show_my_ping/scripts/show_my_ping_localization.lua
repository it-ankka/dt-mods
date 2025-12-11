local mod = get_mod("show_my_ping")
---@type ShowMyPingSettingNames
---@diagnostic disable-next-line: assign-type-mismatch
local SettingNames = mod:io_dofile("show_my_ping/scripts/setting_names")

return {
  mod_name = {
    en = "Show My Ping",
  },
  mod_description = {
    en = "A simple mod for showing your ping during gameplay",
  },
  [SettingNames.HorizontalAlignment] = {
    en = "Horizontal alignment"
  },
  [SettingNames.VerticalAlignment] = {
    en = "Vertical alignment"
  },
  left = {
    en = "Left"
  },
  center = {
    en = "Center"
  },
  right = {
    en = "Right"
  },
  top = {
    en = "Top"
  },
  bottom = {
    en = "Bottom"
  },
}
