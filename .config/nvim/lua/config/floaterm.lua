return {
  border = true,
  size = { h = 70, w = 80 },
  terminals = {
    { name = "Terminal" },
    { name = "Terminal", cmd = "htop" },
  },
  mappings = {
    term = function(buf)
      vim.keymap.set({ "n", "t" }, "<C-p>", function()
        require("floaterm.api").cycle_term_bufs "prev"
      end, { buffer = buf })
    end,
  },
}
