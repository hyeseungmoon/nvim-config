return {
  {
    name = "Run Python (venv + vmux pane)",

    builder = function()
      local file = vim.fn.expand("%:p")
      local python = require("venv-selector").python() or "python"

      return {
        cmd = { "vmux" },
        args = {
          "split-pane",
          "-v",
          "-d",
          python,
          file,
        },
        components = {
          "default",
        },
      }
    end,

    condition = {
      filetype = { "python" },
    },
  },
}
