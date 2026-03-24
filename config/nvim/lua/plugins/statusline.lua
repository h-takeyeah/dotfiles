return {
  -- Status
  {
    "vim-airline/vim-airline", -- Lean & mean status/tabline
    dependencies = { "vim-airline/vim-airline-themes" },
    init = function()
      vim.g.airline_theme = "desertink"
    end
  },
}
