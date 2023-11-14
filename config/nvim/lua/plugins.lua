return {
  -- Plugin manager for Neovim
  { "wbthomason/packer.nvim" }, -- Packer

  -- LSP and completion
  { "neovim/nvim-lspconfig" }, -- Quickstart configs for Nvim LSP
  {
    "hrsh7th/nvim-cmp", -- A completion engine plugin
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
    },
  },

  -- LSP manager (successor for nvim-lsp-installer)
  { "williamboman/mason.nvim" },

  -- Colorschemes
  { "morhetz/gruvbox" }, -- gruvbox
  { "lifepillar/vim-solarized8" }, -- true-color solarized
  { "w0ng/vim-hybrid" }, -- hybrid
  { "cocopon/iceberg.vim" }, -- Bluish color scheme

  -- Status
  { "vim-airline/vim-airline" }, -- Lean & mean status/tabline

  { "lewis6991/gitsigns.nvim" }, -- Git integration for buffers

  -- Code format
  { "editorconfig/editorconfig-vim" }, -- EditorConfig plugin for Vim

  -- Go
  { "mattn/vim-goimports" }, -- Auto-formatting with `:w`
}
