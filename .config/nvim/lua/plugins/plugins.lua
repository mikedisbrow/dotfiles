-- plugins and shit
-- https://www.lazyvim.org/configuration/recipes
return {
  {
    -- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      light_style = "day",
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
  },

  -- random color schemes I kind of like
  { "rebelot/kanagawa.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "mhartington/oceanic-next", lazy = true },
  { "marko-cerovac/material.nvim", lazy = true },
  { "olimorris/onedarkpro.nvim", lazy = true },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  -- Add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- telescope add keymap to browse plugins
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- https://github.com/nvim-lualine/lualine.nvim
  -- https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua

  -- +-------------------------------------------------+
  -- | A | B | C                             X | Y | Z |
  -- +-------------------------------------------------+
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },
    },
  },

  -- add this to your lua/plugins.lua or the file you keep your other plugins:
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    enable = false,
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
  },
}
