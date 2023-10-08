return {
	"goolord/alpha-nvim",
	event = { "VimEnter" },
	config = function()
		local alpha = require("alpha")
		alpha.setup(require("alpha.themes.startify").config)
	end,
}
