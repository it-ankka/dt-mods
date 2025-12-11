return {
  run = function()
    fassert(rawget(_G, "new_mod"), "`show_my_ping` encountered an error loading the Darktide Mod Framework.")

    new_mod("show_my_ping", {
      mod_script       = "show_my_ping/scripts/show_my_ping",
      mod_data         = "show_my_ping/scripts/show_my_ping_data",
      mod_localization = "show_my_ping/scripts/show_my_ping_localization",
    })
  end,
  packages = {},
}
