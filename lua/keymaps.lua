local builtin = require("telescope.builtin")

local function delete_current_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Current buffer has no file to delete", vim.log.levels.WARN)
    return
  end

  if vim.fn.confirm("Delete " .. file .. "?", "&Yes\n&No", 2) ~= 1 then
    return
  end

  local result = vim.fn.delete(file)
  if result ~= 0 then
    vim.notify("Could not delete " .. file, vim.log.levels.ERROR)
    return
  end

  vim.cmd("bdelete!")
end


-- Go to definition
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

-- Live grep (Control + Shift + F)
vim.keymap.set("n", "<C-S-f>", builtin.live_grep, { desc = "Live grep" })

-- Find hidden and Git-ignored files only when explicitly requested.
vim.keymap.set("n", "<leader>fI", function()
  builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "Find ignored files" })

-- Clipboard shortcuts. unnamedplus also makes ordinary y/p use the system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", '\"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '\"+yy', { desc = "Yank line to system clipboard" })

vim.keymap.set("n", "<leader>fd", delete_current_file, { desc = "Delete current file" })

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


