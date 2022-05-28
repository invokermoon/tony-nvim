local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify('Failed loading lsconfig ' .. _)
	return
end




require("user.lsp.diagnostics")
require("user.lsp.nvim-lsp-installer")
require("user.lsp.nvim-lspconfig")
require("user.lsp.lsp-signature")
