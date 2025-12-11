local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")

local SCENEGRAPH_ID = "show_ping"

---@class ShowPingElementDefinitions
local ShowPingElementDefinitions = {
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
  },
  scenegraph_id = SCENEGRAPH_ID
}
return ShowPingElementDefinitions
