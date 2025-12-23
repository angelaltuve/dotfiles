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
    yaml = { "yamlfmt" },

    -- Databases
    sql = { "sqlfluff" },
    mysql = { "sqlfluff" },
    plsql = { "sqlfluff" },

    -- Documentation
    markdown = { "prettier" },
    latex = { "latexindent" },
    tex = { "latexindent" },
  },
}
