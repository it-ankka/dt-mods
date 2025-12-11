return {
  run = function()
    fassert(rawget(_G, "new_mod"), "`show-my-ping` encountered an error loading the Darktide Mod Framework.")

    new_mod("show-my-ping", {
      mod_script       = "show-my-ping/scripts/show-my-ping",
      mod_data         = "show-my-ping/scripts/show-my-ping_data",
      mod_localization = "show-my-ping/scripts/show-my-ping_localization",
    })
  end,
  packages = {},
}
