-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-tool-installer to configure package installations
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Language Servers
        "lua-language-server",
        "astro-language-server",
        "bash-language-server",
        "cmake-language-server",
        "css-lsp",
        "dockerfile-language-server",
        "gopls",
        "html-lsp",
        "json-lsp",
        "jdtls", -- java
        "typescript-language-server", -- javascript / typescript
        "kotlin-language-server", -- kotlin
        "marksman", -- markdown
        "intelephense", -- php
        "prisma-language-server",
        "pyright", -- python
        "taplo", -- toml
        "tailwindcss-language-server",
        "terraform-ls",
        "lemminx", -- xml
        "yaml-language-server",
        "sqlls",
        "graphql-language-service-cli",
        "biome",

        -- Formatters/Linters
        "stylua",

        -- Debuggers
        "debugpy", -- python debugger
      },
    },
  },
}
