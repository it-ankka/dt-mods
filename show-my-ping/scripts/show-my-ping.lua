---@class DMFMod
local mod              = get_mod("show-my-ping")
local DESCRIPTION      = "ping [average] (Show current ping)"

local last_ping        = 0
local measures         = {}

local hud_ping_element = {
  class_name = "HudPingElement",
  filename = "show-my-ping/scripts/hud_ping_element",
}

---@param num number
---@return integer
local function round(num) return math.floor(num + 0.5) end

---@param ping number
local function add_measure(ping)
  if type(ping) == "number" then
    table.insert(measures, ping)
    local remove_count = #measures - 20
    if remove_count < 1 then
      return
    end
    for _ = 1, remove_count do
      table.remove(measures, 1)
    end
  end
end

---@return integer
mod.get_average_ping = function()
  if table.is_empty(measures) then return -1 end
  return round(table.average(measures))
end

--@return integer
mod.get_ping = function()
  local ping = last_ping

  if (type(ping) ~= "number") then return -1 end
  return round(ping)
end

mod:command("ping", DESCRIPTION, function(avg)
  if avg == nil then
    mod:echo("PING %d", mod.get_ping())
    return
  end
  mod:echo("AVERAGE PING %d", mod.get_average_ping())
end)


mod.on_all_mods_loaded = function()
  ---@diagnostic disable-next-line: missing-fields
  if not mod:register_hud_element({
        class_name = hud_ping_element.class_name,
        filename = hud_ping_element.filename,
        use_hud_scale = true,
        visibility_groups = {
          "tactical_overlay",
          "alive",
          "dead",
        },
      }) then
    mod:error("Failed to display ping")
  end

  mod:hook_safe(CLASS.PingReporter, "_take_measure", function(self, dt)
    last_ping = self._measures[#self._measures]
    add_measure(last_ping)
  end)
end
