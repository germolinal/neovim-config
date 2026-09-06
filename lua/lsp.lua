local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
})

vim.lsp.config("gopls", {
  capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "rust_analyzer",
  "gopls",
  "ts_ls",
})

vim.lsp.inlay_hint.enable(true)

vim.lsp.enable("svelte")

