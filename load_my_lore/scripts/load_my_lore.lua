---@class DMFMod
local mod = get_mod("load_my_lore")

local LORE = mod:io_dofile("load_my_lore/scripts/lore")
DESCRIPTION = "Return random lore fact"

mod:command("lore", DESCRIPTION, function()
  lore_idx = math.random(1, lore_count)
  if LORE ~= nil and LORE[lore_idx] ~= nil then
    mod:echo(LORE[lore_idx])
    return
  end
end)

mod.on_all_mods_loaded = function()
  mod:hook_origin(CLASS.LoadingView, "_update_next_hint", function(self)
    local lore_count = #LORE

    self._hint_index = self._hint_index and self._hint_index % lore_count + 1 or math.random(1, lore_count)

    if LORE ~= nil and LORE[self._hint_index] ~= nil then
      local widget = self._widgets_by_name.hint_text
      widget.content.text = LORE[self._hint_index]
    end

    self._update_hint_text = nil
  end)
end
