local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")

local mod = get_mod("show-my-ping")
local SCENEGRAPH_ID = "show_ping"

---@class HudPingElement: HudElementBase
HudPingElement = class("HudPingElement", "HudElementBase")


local Definitions = {
  scenegraph_definition = {
    screen = UIWorkspaceSettings.screen,
    [SCENEGRAPH_ID] = {
      parent = "screen",
      vertical_alignment = "top",
      horizontal_alignment = "center",
      size = { 40, 40 },
      position = { 0, 10, 0 },
      offset = { 0, 0, 0 }
    }
  },
  widget_definitions = {
    ping_widget = UIWidget.create_definition({
      {
        pass_type = "text",
        value = "",
        value_id = "ping_text",
        style_id = "ping_text",
        style = {
          font_type = "machine_medium",
          font_size = 28,
          drop_shadow = true,
          text_vertical_alignment = "center",
          text_horizontal_alignment = "center",
          text_color = Color.white(255, true),
          offset = { 0, 0, 1 },
        }
      }
    }, SCENEGRAPH_ID)
  }
}

function HudPingElement:init(parent, draw_layer, start_scale)
  HudPingElement.super.init(self, parent, draw_layer, start_scale, Definitions)
  self._ping_cache = 0
end

function HudPingElement:update(dt, ui_renderer, render_settings, input_service)
  local ping = mod:get_ping()
  if ping ~= self._ping_cache then
    self._ping_cache = ping
    local ping_widget = self._widgets_by_name.ping_widget
    ping_widget.content.ping_text = ping
  end
end

return HudPingElement
