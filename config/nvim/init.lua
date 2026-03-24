local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- setup lazy end

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
vim.cmd([[
  syntax enable
  let g:airline_powerline_fonts = 1
  "fix truncated column number issue (workaround)
  let g:airline_section_z = "%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#%#__accent_bold#%{g:airline_symbols.colnr}%v %#__restore__#"
  let g:airline#extensions#tabline#enabled = 1
]])

-- Set variables
vim.g.netrw_liststyle = 3

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

-- other config
require("config.color") -- colorscheme
require("lazy").setup({
  spec = {
    { import = "plugins" },
  }
})
