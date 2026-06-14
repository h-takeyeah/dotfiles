return {
  -- LSP and completion
  {
    "neovim/nvim-lspconfig", -- Quickstart configs for Nvim LSP
    config = function(_, _)
      -- For LSP diagnos auto popup
      vim.opt.updatetime = 250

      -- LSP
      -- Original LSP configuration:
      -- https://github.com/neovim/nvim-lspconfig#suggested-configuration

      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = {noremap = true, silent = true}
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      local mylsp_group = vim.api.nvim_create_augroup("MyLsp", {clear = true})
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Attach key mappings for LSP functionalities",
        group = mylsp_group,
        callback = function(args)
          local bufnr = args.buf
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = {noremap = true, silent = true, buffer = bufnr}
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

          -- See [UI Customization](https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization)
          -- disable virtual_text
          vim.diagnostic.config({virtual_text = false})
          -- show diagnostic on hover
          vim.api.nvim_create_autocmd("CursorHold", {
            group = mylsp_group,
            buffer = bufnr,
            callback = function()
              local opts = {
                focusable = false,
                close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
                prefix = " ",
                scope = "cursor",
              }
              vim.diagnostic.open_float(nil, opts)
            end,
          })

          vim.api.nvim_clear_autocmds({
            group = mylsp_group,
            event = "BufWritePre",
            buffer = bufnr,
          })

          -- https://go.dev/gopls/editor/vim#neovim-imports
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = mylsp_group,
            buffer = bufnr,
            callback = function()
		      --print(string.format("event fired: %s", vim.inspect(ev)))
              local client = vim.lsp.get_clients({buffer = bufnr})[1]
              local position_enc = (client and client.offset_encoding) or "utf-16"
              local params = vim.lsp.util.make_range_params(nil, position_enc)
              params.context = {only = {"source.organizeImports"}}
              -- organize imports if needed
              local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
              for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                  if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                  end
                end
              end
              -- format
              vim.lsp.buf.format({async = false})
            end
          })
        end
      })

      vim.lsp.config(
        "*",
        (function()
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
          opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
          return opts
        end)()
      )

      vim.lsp.config("efm", {
        filetypes = {"yaml"},
        init_options = {documentFormatting = true},
      })
      vim.lsp.enable({
        "clangd",
        "cssls",
        "denols",
        "efm",
        "eslint",
        "gopls",
        "pyright",
        -- "pylyzer",
        "rust_analyzer",
        "terraformls",
        "tflint",
        "ts_ls",
        "zls"
      })
      -- LSP setup end

      -- Complement
      vim.opt.completeopt = {"menu", "menuone", "noselect", "noinsert"}
      local cmp = require("cmp") -- Complement engine
      cmp.setup({
        snippet = {
          expand = function(args)
            -- do nothing
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = {
          { name = "nvim_lsp" }
        }
      })
      -- Complement setup end
    end,
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
}
