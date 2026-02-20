return {

  ----------------------------------------------------------------------
  -- Colorscheme
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
  -- UI Components
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
    "akinsho/bufferline.nvim",
    dependencies = "moll/vim-bbye",
    lazy = false,
    opts = function()
      return require "config.bufferline"
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
  -- File Management
  ----------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "config.nvimtree"
    end,
  },

  ----------------------------------------------------------------------
  -- Productivity & Writing
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
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
        backgrounds = {
          "Headline1Bg",
          "Headline2Bg",
          "Headline3Bg",
          "Headline4Bg",
          "Headline5Bg",
          "Headline6Bg",
        },
        foregrounds = {
          "Headline1Fg",
          "Headline2Fg",
          "Headline3Fg",
          "Headline4Fg",
          "Headline5Fg",
          "Headline6Fg",
        },
      },
      checkbox = { enabled = false },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  ----------------------------------------------------------------------
  -- Git
  ----------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    opts = function()
      return require "config.gitsigns"
    end,
  },

  ----------------------------------------------------------------------
  -- LSP & Completion
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
    dependencies = { "mason-org/mason-registry" },
    opts = function()
      return require "config.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)
      local mason_registry = require "mason-registry"
      local ensure_installed = opts.ensure_installed or {}

      -- Ensure all listed tools are installed
      mason_registry.refresh(function()
        for _, tool in ipairs(ensure_installed) do
          local ok, package = pcall(mason_registry.get_package, tool)
          if ok and not package:is_installed() then
            package:install()
          end
        end
      end)
    end,
  },

  -- CMP Stack
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {

      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          local luasnip = require "luasnip"
          luasnip.filetype_extend("javascriptreact", { "html" })
          luasnip.filetype_extend("typescriptreact", { "html" })
          luasnip.filetype_extend("svelte", { "html" })
          require "config.luasnip"
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          require("cmp").event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done()
          )
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

      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "https://codeberg.org/FelipeLema/cmp-async-path.git",
      "f3fora/cmp-spell",
    },

    opts = function()
      return require "config.cmp"
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    cmd = { "SupermavenStart", "SupermavenToggle" },
    opts = {},
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

  ---------------------------------------------------------------------
  ---
  ---------------------------------------------------------------------

  {
    "mfussenegger/nvim-lint",
    event = "User FilePost",
    config = function()
      require "config.lint"
    end,
  },

  ----------------------------------------------------------------------
  -- Telescope
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
  -- Treesitter
  ----------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate | TSInstallAll",
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
  -- Formatting
  ----------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = function()
      return require "config.conform"
    end,
  },

  ----------------------------------------------------------------------
  -- Debugging (DAP)
  ----------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    ft = { "python" },
    cmd = {
      "DapToggleBreakpoint",
      "DapContinue",
      "DapStepOver",
      "DapStepIn",
      "DapStepOut",
      "DapTerminate",
    },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
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
  -- Databases
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
  -- Utilities
  ----------------------------------------------------------------------
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "emmanueltouzery/decisive.nvim" },

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

  {
    "m4xshen/smartcolumn.nvim",
    event = "User FilePost",
    opts = {
      colorcolumn = { "80" },
      scope = "window",
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "NvimTree",
        "lazy",
        "mason",
        "checkhealth",
        "lspinfo",
        "noice",
        "Trouble",
        "fish",
        "zsh",
        "latex",
      },
      custom_colorcolumn = {
        lua = "100",
        python = "88",
        go = "100",
        rust = "100",
        javascript = "120",
        typescript = "120",
      },
    },
  },

  {
    "tpope/vim-sleuth",
    event = "User FilePost",
  },

  {
    "numToStr/Comment.nvim",
    event = "User FilePost",
    opts = {},
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  {
    "cappyzawa/trim.nvim",
    cmd = { "TrimToggle", "Trim" },
    event = "User Filepost",
    opts = {
      ft_blocklist = { "markdown" },
    },
  },

  {
    "nvzone/floaterm",
    cmd = "FloatermToggle",
    dependencies = "nvzone/volt",
    opts = function()
      return require "config.floaterm"
    end,
  },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },

  {
    "HakonHarnes/img-clip.nvim",
    cmd = { "PasteImage", "ImgClipDebug", "ImgClipConfig" },
    keys = {
      {
        "<leader>v",
        "<cmd>PasteImage<cr>",
        desc = "Paste image from system clipboard",
      },
    },
    opts = function()
      return require "config.img-clip"
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
    opts = {
      search = {},
      options = {},
    },
  },
}
