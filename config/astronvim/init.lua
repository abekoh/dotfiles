return {
  options = {
    opt = {
      relativenumber = false,
      wrap = true,
    },
  },

  colorscheme = "tender",

  lsp = {
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
      "nvim-treesitter/nvim-treesitter",
      opts = {
        auto_install = true,
      }
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = function(_, opts)
        opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
          -- "ansiblels",
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
          -- "solargraph",   -- ruby
          "taplo",        -- toml
          "tailwindcss",
          "terraformls",
          "lemminx", -- xml
          "yamlls",
          "sqlls",
          -- "hls", -- haskell
          "graphql",
        })
      end,
    },
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
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "python", "delve" }
      }
    },
    {
      "imsnif/kdl.vim",
    },
  },
}
