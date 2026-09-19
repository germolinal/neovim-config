local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason downloads these servers into Neovim's data directory on first startup.
require("mason-lspconfig").setup({
  ensure_installed = {
    "rust_analyzer",
    "gopls",
    "ts_ls",
    "svelte",
    "terraformls",
    "yamlls",
    "taplo",
    "pyright",
  },
})

local servers = {
  "rust_analyzer",
  "gopls",
  "ts_ls",
  "svelte",
  "terraformls", -- Terraform
  "yamlls",      -- YAML
  "taplo",       -- TOML
  "pyright",     -- Python
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

vim.lsp.enable(servers)
vim.lsp.inlay_hint.enable(true)
