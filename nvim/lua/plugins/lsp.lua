return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruff = { mason = false },
      asm_lsp = { mason = false, filetypes = { "asm", "nasm" } },
    },
    ---@type table<string, fun(server:string, opts):boolean?>
    setup = {
      rust_analyser = function(_, opts)
        opts.settings({
          diagnostics = {
            enable = true,
          },
          inlayHints = {
            typeHints = { enable = true },
          },
          experimental = {
            serverStatusNotification = true,
          },
        })
      end,
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-8" }
        opts.cmd = { "clangd", "--header-insertion=never", "--background-index", "--clang-tidy", "--log=verbose" }
      end,
      zls = function(_, opts)
        opts.enable_inlay_hints = true
        opts.use_comptime_interpreter = true
      end,
      ruff = function()
        LazyVim.lsp.on_attach(function(client, _)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end, "ruff")
      end,
    },
  },
}
