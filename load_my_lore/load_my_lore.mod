return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`load_my_lore` encountered an error loading the Darktide Mod Framework.")

		new_mod("load_my_lore", {
			mod_script       = "load_my_lore/scripts/load_my_lore",
			mod_data         = "load_my_lore/scripts/load_my_lore_data",
			mod_localization = "load_my_lore/scripts/load_my_lore_localization",
		})
	end,
	packages = {},
}
