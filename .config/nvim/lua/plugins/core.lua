return {
  -- LAZYVIM CONFIG
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  -- add telescope-fzf-native
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- PYTHON setup is still a work in progress, seems to collide with .vscode folder settings?
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- pyright = {}
        -- pylsp = {
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         pycodestyle = { enabled = false },
        --         pylint = { enabled = true },
        --       },
        --     },
        --   },
        -- },
      },
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "djlint",
        "flake8",
        "isort",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "pyproject-flake8",
        "python-lsp-server",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
