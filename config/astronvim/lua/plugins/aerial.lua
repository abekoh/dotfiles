---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- Prefer Aerial's Markdown backend to avoid a Neovim 0.12
    -- Treesitter capture incompatibility when parsing headings.
    opts.backends = { "lsp", "markdown", "treesitter", "man" }
  end,
}
