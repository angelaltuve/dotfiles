return {

  ----------------------------------------------------------------------
  -- 🟪 Colorscheme
  ----------------------------------------------------------------------
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    config = function()
      require("neopywal").setup {
        transparent_background = true,
        custom_colors = {},
        custom_highlights = {},
      }
      vim.cmd.colorscheme "neopywal"
    end,
  },

  ----------------------------------------------------------------------
  -- 🟦 UI Components
  ----------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = function()
      return require "config.lualine"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "|" },
      scope = { char = "|" },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
      require("ibl.hooks").register(
        require("ibl.hooks").type.WHITESPACE,
        require("ibl.hooks").builtin.hide_first_space_indent_level
      )
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerToggle",
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },

  ----------------------------------------------------------------------
  -- 🟩 File Management
  ----------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "config.nvimtree"
    end,
  },

  ----------------------------------------------------------------------
  -- 🟧 Productivity & Writing
  ----------------------------------------------------------------------
  {
    "kylechui/nvim-surround",
    event = "User FilePost",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    opts = {
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = {} },
      checkbox = { enabled = false },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },

  ----------------------------------------------------------------------
  -- 🟥 Git
  ----------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    opts = function()
      return require "config.gitsigns"
    end,
  },

  ----------------------------------------------------------------------
  -- 🟨 LSP & Completion
  ----------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "config.lspconfig"
    end,
  },

  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    build = ":MasonUpdate",
    opts = function()
      return require "config.mason"
    end,
  },

  -- CMP Stack
  {
    "hrsh7th/nvim-cmp",
    --event = "InsertEnter",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "config.luasnip"
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = { fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
      },
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "https://codeberg.org/FelipeLema/cmp-async-path.git",
    },
    opts = function()
      return require "config.cmp"
    end,
  },

  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmp = require "cmp"

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  ----------------------------------------------------------------------
  -- 🔍 Telescope
  ----------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "2kabhishek/nerdy.nvim" },
      { "debugloop/telescope-undo.nvim" },
    },
    opts = function()
      return require "config.telescope"
    end,
  },

  ----------------------------------------------------------------------
  -- 🌳 Treesitter
  ----------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "config.treesitter"
    end,
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
      { "hiphish/rainbow-delimiters.nvim", event = "User FilePost" },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  ----------------------------------------------------------------------
  -- 🧹 Formatting
  ----------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = function()
      return require "config.conform"
    end,
  },

  ----------------------------------------------------------------------
  -- 🐞 Debugging (DAP)
  ----------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    ft = { "java", "bash", "python", "sh" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require "config.dap"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  ----------------------------------------------------------------------
  -- 🗄 Databases
  ----------------------------------------------------------------------
  {
    "kristijanhusak/vim-dadbod-ui",
    ft = { "sql", "mysql", "plsql" },
    dependencies = {
      { "tpope/vim-dadbod", cmd = "DB" },
      { "kristijanhusak/vim-dadbod-completion" },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
  },

  ----------------------------------------------------------------------
  -- 🧰 Utilities
  ----------------------------------------------------------------------
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "numToStr/FTerm.nvim" },

  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
  },

  { "m4xshen/smartcolumn.nvim", event = "User FilePost" },
  { "tpope/vim-sleuth", event = "User FilePost" },
  { "emmanueltouzery/decisive.nvim" },

  {
    "numToStr/Comment.nvim",
    event = "User FilePost",
    opts = function()
      require "config.comment"
    end,
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = "FloatermToggle",
  },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
}
