return {
  colorscheme = "tender",

  plugins = {
    {
      "jacoborus/tender.vim",
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
          }
        })
      end,
    },
  },
}
