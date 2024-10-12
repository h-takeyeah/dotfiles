return {
  -- LSP and completion
  {
    "neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
    config = function(_, _)
      vim.opt.updatetime = 250
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Attach key mappings for LSP functionalities",
        callback = function(args)
          --    print(vim.inspect(args))
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          end
          if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
          end

          local opts = { silent = true, buffer = bufnr }
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

          vim.diagnostic.config({
            virtual_text = false,
            float = {
              border = "rounded",
              header = "",
              prefix = "",
            },
          })

          vim.api.nvim_create_autocmd("CursorHold", {
            desc = "Show diagnostic LSP on hover",
            buffer = bufnr,
            callback = function()
              vim.diagnostic.open_float()
            end,
          })
        end
      })

      local lspconfig = require("lspconfig")
      local servers = { "clangd", "pylyzer" }

      for _, server_name in pairs(servers) do
        lspconfig[server_name].setup({})
      end

      -- Note: nvim-cmp by default will start suggesting completions as you type
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        })
      })
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
  { "williamboman/mason.nvim", config = true },

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
