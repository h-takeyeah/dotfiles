return {
  -- LSP and completion
  {
    "neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
    config = function(_, _)
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Attach key mappings for LSP functionalities",
        callback = function(_args)
          --    print(vim.inspect(_args))
          local opts = { silent = true }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
        end
      })

      local lspconfig = require("lspconfig")
      local servers = { "clangd" }

      for _, server_name in pairs(servers) do
        lspconfig[server_name].setup({})
      end
    end
  },
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
