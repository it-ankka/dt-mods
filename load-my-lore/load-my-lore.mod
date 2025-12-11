return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`load-my-lore` encountered an error loading the Darktide Mod Framework.")

		new_mod("load-my-lore", {
			mod_script       = "load-my-lore/scripts/load-my-lore",
			mod_data         = "load-my-lore/scripts/load-my-lore_data",
			mod_localization = "load-my-lore/scripts/load-my-lore_localization",
		})
	end,
	packages = {},
}
