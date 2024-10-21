-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
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
        "ts_ls",        -- javascript / typescript
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
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        -- add more arguments for adding more debuggers
      },
    },
  },
}
