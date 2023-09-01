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
      "goolord/alpha-nvim",
      opts = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {}
        dashboard.section.buttons.val = {}
      end
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

  -- https://astronvim.com/Recipes/yaml_ansible
  -- polish = function()
  --   local function yaml_ft(path, bufnr)
  --     -- get content of buffer as string
  --     local content = vim.filetype.getlines(bufnr)
  --     if type(content) == "table" then content = table.concat(content, "\n") end
  --
  --     -- check if file is in roles, tasks, or handlers folder
  --     local path_regex = vim.regex "(tasks\\|roles\\|handlers)/"
  --     if path_regex and path_regex:match_str(path) then return "yaml.ansible" end
  --     -- check for known ansible playbook text and if found, return yaml.ansible
  --     local regex = vim.regex "hosts:\\|tasks:"
  --     if regex and regex:match_str(content) then return "yaml.ansible" end
  --
  --     -- return yaml if nothing else
  --     return "yaml"
  --   end
  --
  --   vim.filetype.add {
  --     extension = {
  --       yml = yaml_ft,
  --       yaml = yaml_ft,
  --     },
  --   }
  -- end,
}
