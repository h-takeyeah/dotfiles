local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- LSP and completion
  { "neovim/nvim-lspconfig" }, -- Quickstart configs for Nvim LSP
  { "hrsh7th/nvim-cmp" }, -- A completion engine plugin
  { "hrsh7th/cmp-nvim-lsp" }, -- nvim-cmp source for neovim builtin LSP client

  -- LSP manager (successor for nvim-lsp-installer)
  { "williamboman/mason.nvim" },

  -- Colorschemes
  { "morhetz/gruvbox", lazy = false }, -- gruvbox
  { "lifepillar/vim-solarized8", lazy = false }, -- true-color solarized
  { "w0ng/vim-hybrid", lazy = false }, -- hybrid
  { "cocopon/iceberg.vim", lazy = false }, -- Bluish color scheme

  -- Status
  { "vim-airline/vim-airline" }, -- Lean & mean status/tabline

  { "lewis6991/gitsigns.nvim" }, -- Git integration for buffers

  -- Code format
  { "editorconfig/editorconfig-vim" }, -- EditorConfig plugin for Vim

  -- Go
  { "mattn/vim-goimports" }, -- Auto-formatting with `:w`
}

require("lazy").setup(plugins)

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.matchtime = 1
vim.opt.wrap = false
vim.opt.wildmenu = true
vim.opt.background = "dark"
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.matchtime = 1
vim.opt.wrap = false
vim.opt.wildmenu = true
vim.opt.background = "dark"
vim.cmd([[
  syntax enable
  colorscheme gruvbox
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
]])

-- Enable true color
if vim.fn.exists("+termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- Set indent options by each language
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.go",
  group = vim.api.nvim_create_augroup("indent_by_filetype", {clear = true}),
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 0
  end,
})
