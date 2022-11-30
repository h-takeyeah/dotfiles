return require("packer").startup(function()
  -- Plugin manager for Neovim
  use "wbthomason/packer.nvim" -- Packer

  -- LSP and completion
  use "neovim/nvim-lspconfig" -- Quickstart configs for Nvim LSP
  use "hrsh7th/nvim-cmp" -- A completion engine plugin
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim builtin LSP client

  -- LSP manager (successor for nvim-lsp-installer)
  use "williamboman/mason.nvim"

  -- Colorschemes
  use "morhetz/gruvbox" -- gruvbox
  use "lifepillar/vim-solarized8" -- true-color solarized
  use "w0ng/vim-hybrid" -- hybrid
  use "cocopon/iceberg.vim" -- Bluish color scheme

  -- Status
  use "vim-airline/vim-airline" -- Lean & mean status/tabline

  use "lewis6991/gitsigns.nvim" -- Git integration for buffers

  -- Code format
  use "editorconfig/editorconfig-vim" -- EditorConfig plugin for Vim

  -- Go
  use "mattn/vim-goimports" -- Auto-formatting with `:w`
end)
