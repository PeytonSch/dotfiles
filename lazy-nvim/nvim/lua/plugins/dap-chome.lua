return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function(_, opts)
      local dap = require("dap")

      -- On Windows Mason installs js-debug-adapter as a .cmd shim.
      -- Resolve it to the full path so nvim-dap can spawn it reliably. [3](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-17/)
      local resolved = vim.fn.exepath("js-debug-adapter")
      local cmd = (resolved ~= "" and resolved) or "js-debug-adapter"

      local function ensure_jsdebug_adapter(name)
        -- LazyVim/mason commonly define js-debug adapters as "server" w/ executable.command. [3](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-17/)
        dap.adapters[name] = dap.adapters[name]
          or {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = cmd,
              args = { "${port}" },
            },
          }

        -- If it already exists, fix command in-place
        local a = dap.adapters[name]
        if type(a) == "table" then
          if a.executable and type(a.executable.command) == "string" then
            local r = vim.fn.exepath(a.executable.command)
            if r ~= "" then
              a.executable.command = r
            end
          elseif type(a.command) == "string" then
            local r = vim.fn.exepath(a.command)
            if r ~= "" then
              a.command = r
            end
          end
        end
      end

      -- js-debug provides these adapter names (pwa-node, pwa-chrome, etc.). [4](https://github.com/mxsdev/nvim-dap-vscode-js)
      for _, name in ipairs({
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
      }) do
        ensure_jsdebug_adapter(name)
      end

      return opts
    end,
  },
}
