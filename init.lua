local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
-- Use the system clipboard for normal yanks, deletes, and puts.
vim.opt.clipboard = "unnamedplus"


if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            pickers = {
		find_files = {
                    find_command = {
                        "fd",
                        "--type", "f",
                        "--hidden",
                        "--exclude", ".git"
                    },
                },
            },
        })
    end,
  },

  {
    "neovim/nvim-lspconfig",
  },

  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "nvim-lspconfig" },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
     "hrsh7th/cmp-nvim-lsp",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "lewis6991/gitsigns.nvim",
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
  "martindur/zdiff.nvim",
  cmd = "Zdiff",
  keys = {
    { "<leader>zd", function() require("zdiff").open() end, desc = "Zdiff (uncommitted)" },
    { "<leader>zD", function() require("zdiff").open("main") end, desc = "Zdiff (vs main)" },
    },
    opts = {},
  }

})

require("lsp")
require("completion")
require("keymaps")
require("treesitter")
require("theme")
require("git")


