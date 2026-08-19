---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- Aerial fetches symbols from every supported backend on initial attach.
    -- Keep Tree-sitter out of Markdown buffers because Neovim 0.12 can produce
    -- heading captures without a `level` node for Aerial's Tree-sitter backend.
    opts.backends = {
      ["_"] = { "lsp", "treesitter", "markdown", "man" },
      markdown = { "lsp", "markdown" },
    }
  end,
}
