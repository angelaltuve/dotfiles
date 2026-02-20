return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,

  ensure_installed = {
    "bash-language-server",
    "black",
    "clangd",
    "clang-format",
    "css-lsp",
    "debugpy",
    "html-lsp",
    "isort",
    "stylua",
    "taplo",
    "typescript-language-server",
    "lua-language-server",
    "markdownlint",
    "marksman",
    "prettier",
    "pylint",
    "basedpyright",
    "shfmt",
    "sql-formatter",
    "yaml-language-server",
    "biome",
    "google-java-format",
    "deno_fmt",
    "taplo",
    "markdownlint-cli2",
    "markdown-toc",
  },
}
