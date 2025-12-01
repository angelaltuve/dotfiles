return {
	actions = {
		redraw = false,
	},

	image = {
		darkmode = false,
		format = "png",

		execute_to_open = function(img)
			return "nsxiv -b " .. img
		end,
	},
}
