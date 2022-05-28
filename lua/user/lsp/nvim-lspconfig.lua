local opts = { noremap=true, silent=false, }
local deps = {
    {"nvim-lsp-installer", "nvim-lsp-installer"},
    {"lsp_signature", "lsp_signature.nvim"},
    {"cmp_nvim_lsp", "cmp-nvim-lsp"},
    {"aerial", "aerial.nvim"},
}

for _, p in pairs(deps) do
    local sts, _ = pcall(require, p[1])
    if not sts then
        vim.notify("[LSP] Not Found " .. p, "warn")
        return
    end
end

-- for _, pk in pairs(deps) do
--     local sts, _ = pcall(vim.cmd, "packadd " .. pk[2])
--     if not sts then
--         vim.notify("LSP] Failed packadd " .. pk, "warn")
--     end
-- end

local lsp_config = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function keymap(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- VIP
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- Format all the file, and there is no proper formating for selected lines
  vim.api.nvim_buf_set_keymap(bufnr, '', '<F2>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- maybe using
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", opts)
end

local function custom_attach(client, bufnr)
    -- require("aerial").on_attach(client)
    keymap(client, bufnr)
end

local servers = {
    'ccls',
    'pyright',
    'rust_analyzer',
    'tsserver',
    'sumneko_lua',
}
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = custom_attach,
        capabilities = capabilities,
        single_file_support = true,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end
