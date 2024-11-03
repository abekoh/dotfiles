---@type LazySpec
return {
  {
    "jacoborus/tender.vim",
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-]>",
            next = "<C-[>",
            dismiss = "<Esc>",
          },
        },
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },
  {
    "t9md/vim-quickhl",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_keymap("n", "<space>m", "<Plug>(quickhl-manual-this)", {})
      vim.api.nvim_set_keymap("x", "<Leader>m", "<Plug>(quickhl-manual-this)", { silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>M", "<Plug>(quickhl-manual-reset)", { silent = true })
      vim.api.nvim_set_keymap("x", "<Leader>M", "<Plug>(quickhl-manual-reset)", { silent = true })
    end,
  },
  {
    "imsnif/kdl.vim",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
}
