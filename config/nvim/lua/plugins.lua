vim.cmd.packadd "packer.nvim"

return require("packer").startup(function()
  -- Plugin manager for Neovim
  use { "wbthomason/packer.nvim", opt = true } -- Packer

  -- LSP and completion
  use {
    "neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
    event = { "CursorHold", "FocusLost" },
    config = function() require("config.lsp") end
  }
  use "hrsh7th/nvim-cmp" -- A completion engine plugin
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim builtin LSP client

  -- LSP manager (successor for nvim-lsp-installer)
  use {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end
  }

  -- Syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use "morhetz/gruvbox" -- gruvbox
  use "lifepillar/vim-solarized8" -- true-color solarized
  use "w0ng/vim-hybrid" -- hybrid
  use "cocopon/iceberg.vim" -- Bluish color scheme

  -- Status
  use {
    "vim-airline/vim-airline", -- Lean & mean status/tabline
    opt = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" }
  }

  use {
    "lewis6991/gitsigns.nvim", -- Git integration for buffers
    opt = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function() require("gitsigns").setup() end
  }

  -- Code format
  use "editorconfig/editorconfig-vim" -- EditorConfig plugin for Vim

  -- Go
  use { "mattn/vim-goimports", opt = true, ft = { "go" } } -- Auto-formatting with `:w`

  use {
    "/home/youtaku/.config/nvim/lua/local-plugin/ryoppippi-bun-to-deno",
    disable = true
  }
end)

-- ref. https://qiita.com/delphinus/items/8160d884d415d7425fcc
