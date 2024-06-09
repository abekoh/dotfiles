return {

  vim.api.nvim_set_keymap("n", "sh", "<C-w>h", {}),
  vim.api.nvim_set_keymap("n", "sj", "<C-w>j", {}),
  vim.api.nvim_set_keymap("n", "sk", "<C-w>k", {}),
  vim.api.nvim_set_keymap("n", "sl", "<C-w>l", {}),

  options = {
    opt = {
      ttyfast = true,
      relativenumber = false,
      wrap = true,
      swapfile = false,
      scrolloff = 5,
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
      "nvim-telescope/telescope.nvim",
      opts = function(_, opts)
        return require("astronvim.utils").extend_tbl(opts, {
          pickers = {
            find_files = {
              hidden = true,
              find_command = function(cfg)
                local find_command = { "rg", "--files", "--color", "never" }
                if not cfg.no_ignore then vim.list_extend(find_command, { "--glob", "!**/.git/**" }) end
                return find_command
              end,
            },
          },
        })
      end,
    },
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
          -- "clangd",
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
          "biome",
          "bufls",
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
      end
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
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      run = "cd app && yarn install",
    },
  },
}
