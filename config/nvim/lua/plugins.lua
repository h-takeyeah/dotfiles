return {
  -- LSP and completion
  {
    "neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
  },
  {
    "hrsh7th/nvim-cmp", -- A completion engine plugin
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
    },
  },

  -- LSP manager (successor for nvim-lsp-installer)
  { "mason-org/mason.nvim", config = true },

  -- Semantic highlights
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = true,
    opt = {
      auto_install = true,
      ensure_installed = { "c", "python" },
      highlight = {
        enabled = true,
        disable = function(_lang, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end
      }
    }
  },

  -- Status
  { "vim-airline/vim-airline" }, -- Lean & mean status/tabline
  { "vim-airline/vim-airline-themes" },

  { "lewis6991/gitsigns.nvim" }, -- Git integration for buffers

  -- Code format
  { "editorconfig/editorconfig-vim" }, -- EditorConfig plugin for Vim
}
