local mod = get_mod("show_my_ping")

---@type ShowPingElementDefinitions
---@diagnostic disable-next-line: assign-type-mismatch
local ShowPingElementDefinitions = mod:io_dofile("show_my_ping/scripts/element/show_ping_element_definitions")

---@class ShowPingElement: HudElementBase
ShowPingElement = class("ShowPingElement", "HudElementBase")

function ShowPingElement:init(parent, draw_layer, start_scale)
  ShowPingElement.super.init(self, parent, draw_layer, start_scale, ShowPingElementDefinitions)
  self._ping_cache = 0
  mod.settings_updated = true
end

---@param ping integer
local get_ping_color = function(ping)
  if ping > 150 then
    return Color.red(255, true)
  elseif ping > 50 then
    return Color.white(255, true)
  end
  return Color.online_green(255, true)
end

function ShowPingElement:update(dt, ui_renderer, render_settings, input_service)
  local ping = mod:get_ping()

  if ping == self._ping_cache then
    return
  end

  self._ping_cache = ping
  local ping_widget = self._widgets_by_name.ping_widget
  if type(ping) == "number" and ping > 0 then
    ping_widget.style.ping_text.text_color = get_ping_color(ping)
    ping_widget.content.ping_text = math.min(ping, 999)
  else
    ping_widget.content.ping_text = ""
  end

  if mod.settings_updated then
    mod.settings_updated = false
    self:set_scenegraph_position(ShowPingElementDefinitions.scenegraph_id, 0, 0, 0,
      mod:get_horizontal_alignment(), mod:get_vertical_alignment())
    ping_widget.dirty = true
  end

  ShowPingElement.super.update(self, dt, ui_renderer, render_settings, input_service)
end

return ShowPingElement
