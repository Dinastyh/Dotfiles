return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "ruff",
      "clangd",
      "lua-language-server",
      "pyright",
      "zls",
      "clang-format",
      "stylua",
      "rust-analyzer",
    },
  },
}
