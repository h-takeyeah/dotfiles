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
vim.cmd([[
  syntax enable
  let g:airline_powerline_fonts = 1
  "fix truncated column number issue (workaround)
  let g:airline_section_z = "%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#%#__accent_bold#%{g:airline_symbols.colnr}%v %#__restore__#"
  let g:airline#extensions#tabline#enabled = 1
]])

-- Set variables
vim.g.netrw_liststyle = 3
vim.g.netrw_browserx_viewer = "xdg-open"

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

-- Make background transparent
vim.api.nvim_create_autocmd({"VimEnter", "Colorscheme"}, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("transparent_bg", {clear = true}),
  callback = function()
    vim.cmd[[
      highlight Normal guibg=none
    ]]
  end,
})

-- Automatically call PackerCompile after plugins.lua update
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})

-- packer
require("plugins")

-- other config
require("config.color") -- colorscheme
require("config.treesitter")-- treesitter
