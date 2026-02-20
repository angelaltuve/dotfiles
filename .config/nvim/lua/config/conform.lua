return {
  formatters_by_ft = {
    lua = { "stylua" },
    java = { "google-java-format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "isort", "black" },
    toml = { "taplo" },

    -- webdev
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },

    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
    svelte = { "deno_fmt" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    yaml = { "yamlfmt" },

    -- Databases
    sql = { "sql-formatter" },
    mysql = { "sql-formatter" },
    plsql = { "sql-formatter" },

    -- Documentation
    markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
    latex = { "latexindent" },
    tex = { "latexindent" },
  },
}
