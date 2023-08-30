return {
  colorscheme = "tender",

  lsp = {
    servers = {
      "ansiblels",
      "astro",
      "bashls",
      "clangd",
      "cmake",
      "cssls",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
      "jdtls",        -- java
      "tsserver",     -- javascript / typescript
      "marksman",     -- markdown
      "intelephense", -- php
      "prismals",
      "pyright",      -- python
      "ruby_ls",
      "taplo",        -- toml
      "tailwindcss",
      "terraformls",
      "lemminx", -- xml
      "yamlls",
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {
          "markdown",
        },
      },
    },
  },

  plugins = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
        },
      }
    },
    {
      "hrsh7th/nvim-cmp",
      opts = function()
        local cmp = require("cmp")
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end)
        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    },
    {
      "jacoborus/tender.vim",
    },
    {
      "zbirenbaum/copilot.lua",
      lazy = true,
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
              accept = "<C-]>",
              next = "<C-[>",
              dismiss = "<Esc>",
            },
          }
        })
      end,
    },
  },
}
