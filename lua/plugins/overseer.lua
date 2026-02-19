return {
  {
    "stevearc/overseer.nvim",
    config = function()
      local overseer = require("overseer")
      overseer.setup()

      -- 템플릿 등록
      overseer.register_template({
        name = "Run current python (venv, module mode)",
        builder = function()
          local python = vim.g.python3_host_prog
          if not python or python == "" then
            python = "python3"
          end

          -- git root
          local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          if root == nil or root == "" then
            root = vim.fn.getcwd()
          end

          -- 현재 파일 경로를 모듈 경로로 변환
          local file = vim.fn.expand("%:r") -- 확장자 제거
          local rel = vim.fn.fnamemodify(file, ":.") -- 프로젝트 루트 기준 상대경로
          local module = rel:gsub("/", ".") -- / → . 변환

          return {
            cmd = { python },
            args = { "-m", module },
            cwd = root,
            components = { "default" },
          }
        end,
        condition = { filetype = { "python" } },
      })

      -- 단축키 설정 🔥
      -- <leader>r : Run current python 템플릿
      vim.keymap.set("n", "<leader>r", function()
        overseer.run_template({ name = "Run current python (venv, module mode)" })
      end, { noremap = true, silent = true })

      -- <leader>t : Overseer Task List 토글
      vim.keymap.set("n", "<leader>t", function()
        overseer.toggle()
      end, { noremap = true, silent = true })
    end,
  },
}
