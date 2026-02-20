local lint = require "lint"

lint.linters_by_ft = {
  go = { "golangcilint" },
  markdown = { "markdownlint", "markdownlint-cli2" },
  python = { "pylint" },
  ruby = { "rubocop" },
  terraform = { "tflint" },
}

-- Configure pylint to use Poetry environment
lint.linters.pylint.cmd = function()
  local util = require "lspconfig.util"
  local bufname = vim.api.nvim_buf_get_name(0)
  local root_dir = vim.fs.dirname(vim.fs.find(".git", { path = bufname, upward = true })[1])
    or vim.fn.getcwd()
    or vim.fn.getcwd()
  local poetry_root = util.root_pattern("poetry.lock", "pyproject.toml")(root_dir)

  if poetry_root then
    local result = vim.fn.system("cd " .. poetry_root .. " && poetry env info -p 2>/dev/null")
    if vim.v.shell_error == 0 then
      local venv = vim.fn.trim(result)
      if venv ~= "" then
        return venv .. "/bin/pylint"
      end
    end
  end

  -- Fallback: check for local .venv directory
  local local_venv = root_dir .. "/.venv"
  if vim.fn.isdirectory(local_venv) == 1 then
    return local_venv .. "/bin/pylint"
  end

  -- Final fallback to system pylint
  return "pylint"
end
