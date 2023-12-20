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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format({async = true}), bufopts)

  -- See [UI Customization](https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization)
  -- disable virtual_text
  vim.diagnostic.config({virtual_text = false})
  -- show diagnostic on hover
  vim.api.nvim_create_autocmd("CursorHold", {
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
end

local lspconfig = require("lspconfig") -- LSP config
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Complement source from LSP
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- https://deno.land/manual@v1.17.3/getting_started/setup_your_environment#neovim-06-and-nvim-lspconfig
lspconfig["denols"].setup({
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {enable = true, unstable = true},
  cmd = {"deno", "lsp"},
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["tsserver"].setup({
  root_dir = lspconfig.util.root_pattern("package.json"),
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = false,
})

lspconfig["gopls"].setup({
  --cmd = {"gopls", "serve", "-rpc.trace", "--debug=localhost:6060"}, -- for debug
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["efm"].setup({
  filetypes = {"yaml"},
  init_options = {documentFormatting = true},
})

lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["rust_analyzer"].setup({
  on_attach = on_attach
})

vim.api.nvim_command([[LspStart]]) -- Start LSPs (required when lspconfig is loaded with delay(lazy load))
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
  sources = cmp.config.sources({
    {name = "nvim_lsp"},
  }, {
    {name = "buffer"},
  }),
})
-- Complement setup end
