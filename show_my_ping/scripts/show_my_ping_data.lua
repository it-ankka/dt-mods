---@class DMFMod
local mod = get_mod("show_my_ping")
---@type ShowMyPingSettingNames
---@diagnostic disable-next-line: assign-type-mismatch
local SettingNames = mod:io_dofile("show_my_ping/scripts/setting_names")

---@return string
function mod:get_horizontal_alignment()
  return mod:get(SettingNames.HorizontalAlignment)
end

---@return string
function mod:get_vertical_alignment()
  return mod:get(SettingNames.HorizontalAlignment)
end

return {
  name = "Show My Ping",
  description = mod:localize("mod_description"),
  is_togglable = true,
  allow_rehooking = true,
  options = {
    widgets = {
      {
        setting_id = SettingNames.HorizontalAlignment,
        type = "dropdown",
        default_value = "center",
        options = {
          { text = "center", value = "center" },
          { text = "left",   value = "left" },
          { text = "right",  value = "right" },
        }
      },
      {
        setting_id = SettingNames.VerticalAlignment,
        type = "dropdown",
        default_value = "top",
        options = {
          { text = "center", value = "center" },
          { text = "top",    value = "top" },
          { text = "bottom", value = "bottom" },
        }
      }
    }
  }
}
