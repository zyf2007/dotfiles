-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable sh as your default shell
vim.opt.shell = "/bin/sh"
-- lvim.transparent_window = true
-- Set a compatible clipboard manager
-- vim.g.clipboard = {
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --lf",
--     ["*"] = "win32yank.exe -o --lf",
--   },
-- }





------------------------------------Plugins------------------------------------------
lvim.plugins = {
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 0")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  }, {
  "ethanholz/nvim-lastplace",
  event = "BufRead",
  config = function()
    require("nvim-lastplace").setup({
      lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
      lastplace_ignore_filetype = {
        "gitcommit", "gitrebase", "svn", "hgcommit",
      },
      lastplace_open_folds = true,
    })
  end,
}, { "sitiom/nvim-numbertoggle" },
  -- Unix commands. Try ":SudoWrite"
  -- Issue with cmp.u.k.recursive appearing when you hit enter.
  -- See: https://github.com/hrsh7th/nvim-cmp/issues/770
  {
    "tpope/vim-eunuch",
    event = "BufRead",
  },

  -- Markers in margin. 'ma' adds marker
  {
    "kshenoy/vim-signature",
    event = "BufRead",
  },

  -- Highlight URL's. http://www.vivaldi.com
  {
    "itchyny/vim-highlighturl",
    event = "BufRead",
  },

  -- -----------------------------------------------------------------------
  -- Suggestions from https://www.lunarvim.org/plugins/03-extra-plugins.html
  -- Navigation plugins
  -- hop
  -- neovim motions on speed!
  -- Better motions
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  --  {
  --    "Pocco81/auto-save.nvim",
  --    config = function()
  --      require("auto-save").setup()
  --    end,
  --  },

}
lvim.builtin.treesitter.rainbow.enable = true
lvim.format_on_save.enabled = true


require 'cmp'.setup {
  sources = {
    { name = 'cmp_tabnine' },
  },
}
require('illuminate').configure({
  enabled = false, -- 禁用 illuminate
})
lvim.log.level = "error"
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>Trouble<cr>", "trouble" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>Trouble diagnostics<cr>", "document" },
  q = { "<cmd>Trouble quickfix<cr>", "quickfix" },
  l = { "<cmd>Trouble loclist<cr>", "loclist" },
  r = { "<cmd>Trouble lsp_references<cr>", "references" },
}




---------------------------------Lualine---------------------------------
