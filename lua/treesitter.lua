vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.syntax = "off"
    end
  end,
})

