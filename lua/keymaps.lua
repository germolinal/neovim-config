local builtin = require("telescope.builtin")

-- Go do definition
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })

-- Go to reference
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Find references" })

-- Find symbol in current file (Control + Shif + O)
vim.keymap.set(
  "n",
  "<C-S-O>",
  builtin.lsp_document_symbols,
  { desc = "Find symbol in current file" }
)

-- Find file (Control + P)
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })

-- Show diagnostics (Space - X - X):
vim.keymap.set(
  "n",
  "<leader>xx",
  builtin.diagnostics,
  { desc = "Show diagnostics" }
)

vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Show diagnostic" }
)

vim.keymap.set(
  "n",
  "<leader>b",
  ":Neotree toggle<CR>",
  { desc = "Toggle file explorer" }
)


vim.keymap.set(
 "n",
 "<C-l>",
 ":vsp<CR><C-w>w",
 { desc = "Vertical split screen", silent=true, noremap=true }
)
