return require("packer").startup(function()
  -- Plugin manager for Neovim
  use "wbthomason/packer.nvim" -- Packer

  -- LSP and completion
  use "neovim/nvim-lspconfig" -- Quickstart configs for Nvim LSP
  use "williamboman/nvim-lsp-installer" -- LSP servers manager
  use "hrsh7th/nvim-cmp" -- A completion engine plugin
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim builtin LSP client

  -- Colorschemes
  use "morhetz/gruvbox" -- gruvbox
  use "lifepillar/vim-solarized8" -- true-color solarized

  -- Status
  use {
    "vim-airline/vim-airline", -- Lean & mean status/tabline
    setup = "vim.cmd[[let g:airline#extensions#whitespace#mixed_indent_algo = 1]]"
  }

  -- Code format
  use "editorconfig/editorconfig-vim" -- EditorConfig plugin for Vim

  -- Go
  use "mattn/vim-goimports" -- Auto-formatting with `:w`
end)

