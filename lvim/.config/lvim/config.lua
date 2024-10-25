-- PLUGINS --
lvim.plugins = {
     {
          'IogaMaster/neocord',
          event = "VeryLazy",
          config = function()
               require('neocord').setup()
          end
     },

     {
          'kosayoda/nvim-lightbulb',
          config = function()
               require("nvim-lightbulb").setup({
                    autocmd = { enabled = true },
                    ignore = {
                         clients = {
                              "ruff",
                         },
                    },
               })
          end
     },
     {
          'nvim-telescope/telescope-ui-select.nvim'
     },
     -- nvim-notify
     {
          'rcarriga/nvim-notify',
          -- lazy = false, -- Load at startup
          config = function()
               -- Set nvim-notify as the default notification handler
               vim.notify = require("notify")

               -- Optional: configure nvim-notify with custom options
               require("notify").setup({
                    stages = "fade_in_slide_out",  -- Animation stages
                    timeout = 3000,                -- Notification timeout
                    background_colour = "#1e222a", -- Background color
                    icons = {
                         ERROR = "",
                         WARN = "",
                         INFO = "",
                         DEBUG = "",
                         TRACE = "✎",
                    }
               })
          end,
     },

     -- Undo Tree
     {
          "jiaoshijie/undotree",
          dependencies = "nvim-lua/plenary.nvim",
          config = true,
          keys = { { "<C-t>", "<cmd>lua require('undotree').toggle()<cr>" } },
     },

     -- Last Place
     {
          "ethanholz/nvim-lastplace",
          config = true,
          opts = {
               lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
               lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
               lastplace_open_folds = true,
          },
     },

     -- Trouble
     {
          "folke/trouble.nvim",
          opts = {
               modes = {
                    cascade = {
                         mode = "diagnostics",
                         filter = function(items)
                              local severity = vim.diagnostic.severity.HINT
                              for _, item in ipairs(items) do
                                   severity = math.min(severity, item.severity)
                              end
                              return vim.tbl_filter(function(item)
                                   return item.severity == severity
                              end, items)
                         end,
                    },
               },
          },
          cmd = "Trouble",
          keys = {
               { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
               { "<leader>xo", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
               { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
               { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
               { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
               { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
               { "<C-l>",      "<cmd>Trouble cascade<cr>",                                   desc = "Cascade Diagnostics (Trouble)" },
               { "<C-l>",      "<cmd>Trouble cascade jump<cr>" },
               { "<C-l>",      "<cmd>Trouble cascade focus<cr>" },
               { "q",          "<cmd>Trouble cascade close<cr>" },
          },
     },
     {
          "CRAG666/code_runner.nvim",
          config = true
     },
     {
          "mrjones2014/nvim-ts-rainbow",
     },
     {
          "ellisonleao/glow.nvim",
          config = true,
          cmd = "Glow"
     },
     {
          'wakatime/vim-wakatime',
          lazy = false
     }
}

lvim.builtin.treesitter.rainbow.enable = true

require('code_runner').setup {
     mode = "term",
     focuse = false,
     term = {
          position = "vert",
          size = 60
     },
     filetype = {
          javascript = "node",
          java = {
               "cd $dir &&",
               "javac $fileName &&",
               "java $fileNameWithoutExt",
          },
          c = {
               "cd $dir &&",
               "gcc $fileName",
               "-o $fileNameWithoutExt &&",
               "$dir/$fileNameWithoutExt",
          },
          cpp = {
               "cd $dir &&",
               "g++ $fileName",
               "-o $fileNameWithoutExt &&",
               "$dir/$fileNameWithoutExt",
          },
          python = "python -u",
          lua = "lua",
          markdown = "glow",
          sh = "bash",
          ruby = "ruby",
          rust = {
               "cd $dir &&",
               "rustc $fileName &&",
               "$dir/$fileNameWithoutExt",
          },
     },
}
require("telescope").setup {
     extensions = {
          ["ui-select"] = {
               require("telescope.themes").get_dropdown {
               }
          }
     }
}

require("telescope").load_extension("ui-select")

-- SETTINGS --
vim.opt.shell = "/bin/sh"
vim.cmd("set expandtab")
vim.cmd("set tabstop=5")
vim.cmd("set softtabstop=5")
vim.cmd("set shiftwidth=5")

-- Colorscheme and Transparency
lvim.colorscheme = "tokyonight-storm"
lvim.transparent_window = true

-- Leader key settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Clipboard integration
vim.api.nvim_set_option("clipboard", "unnamedplus")



-- KEYBINDS --
vim.api.nvim_set_keymap('', '<BS>', 'X', { noremap = true, silent = true }) -- Normal mode
vim.keymap.set("v", "<BS>", '"_d')                                          -- Visual mode

-- Keybindings for clipboard
vim.keymap.set('v', '<C-y>', '"+y', { noremap = true, silent = true }) -- Copy to system clipboard
vim.keymap.set('v', '<C-x>', '"+d', { noremap = true, silent = true }) -- Cut to system clipboard
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Paste from system clipboard

-- Navigation and editing keybindings
vim.keymap.set('n', '<C-e>', '$', { noremap = true, silent = true })                  -- End of line
vim.keymap.set('n', '<C-b>', '^', { noremap = true, silent = true })                  -- Beginning of line
vim.keymap.set('n', '<C-z>', 'u', { noremap = true, silent = true })                  -- Undo
vim.keymap.set('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })             -- Undo in insert mode
vim.keymap.set('n', '<C-S-z>', '<C-r>', { noremap = true, silent = true })            -- Redo
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })               -- Select all
vim.keymap.set('i', '<C-a>', '<Esc>ggVG<CR>a', { noremap = true, silent = true })     -- Select all in insert mode
vim.api.nvim_set_keymap('v', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true }) -- Select all in visual mode

-- Nvim Tree toggle
vim.keymap.set("n", "<C-p>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Comment toggle in visual mode
vim.keymap.set("v", "<C-#>", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
     { noremap = true, silent = true })

-- Delete selected text in visual mode without cutting
vim.api.nvim_set_keymap('v', '<Del>', '"_d', { noremap = true, silent = true })

-- LSP keybindings
lvim.keys.normal_mode["<C-k>"] = ":lua vim.lsp.buf.format()<CR>"
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-o>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })

-- LSP actions
lvim.keys.normal_mode["<C-h>"] = vim.lsp.buf.hover
lvim.keys.normal_mode["<C-d>"] = vim.lsp.buf.definition
lvim.keys.visual_mode["?"] = vim.lsp.buf.code_action
lvim.keys.normal_mode["?"] = vim.lsp.buf.code_action

-- Additional keybindings for buffers and diagnostics
lvim.keys.normal_mode["<C-Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-Del>"] = function()
     local current_value = vim.diagnostic.config().virtual_text
     vim.diagnostic.config({ virtual_text = not current_value })
end

-- Capital I and I remappings
-- lvim.keys.normal_mode["I"] = "i" -- Insert after the cursor
lvim.keys.normal_mode["I"] = "a" -- Insert at the cursor

-- Save keybindings
vim.api.nvim_set_keymap('n', '<C-S-s>', ':saveas ', { noremap = true, silent = false })      -- Save as new name
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })           -- Save
vim.api.nvim_set_keymap('i', '<C-S-s>', '<C-o>:saveas ', { noremap = true, silent = false }) -- Save as new name in insert mode
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })      -- Save in insert mode

-- Quit with Ctrl + q
lvim.keys.normal_mode["<C-q>"] = ":q<CR>"
lvim.keys.insert_mode["<C-q>"] = "<C-o>:q<CR>"

-- Double-tap 'v' to visually select the word under the cursor
vim.api.nvim_set_keymap('n', 'vv', ':normal! viw<CR>', { noremap = true, silent = true })

-- Delete word under cursor with Shift+Delete
vim.keymap.set('n', '<S-Del>', 'daw', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Del>', '<C-o>daw', { noremap = true, silent = true })

-- Move up/down by paragraph in all modes
lvim.keys.normal_mode["<S-Up>"] = "{"
lvim.keys.normal_mode["<S-Down>"] = "}"

-- Run Code
vim.keymap.set('n', '<C-r>', ':RunFile<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rc', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })

-- Keybindings for window navigation using Alt + arrow keys
vim.keymap.set('n', '<A-Up>', '<C-w>k', { noremap = true, silent = true })    -- Move up to the previous window
vim.keymap.set('n', '<A-Down>', '<C-w>j', { noremap = true, silent = true })  -- Move down to the next window
vim.keymap.set('n', '<A-Left>', '<C-w>h', { noremap = true, silent = true })  -- Move left to the previous window
vim.keymap.set('n', '<A-Right>', '<C-w>l', { noremap = true, silent = true }) -- Move right to the next window

-- Get Time
vim.keymap.set('n', '<C-Esc>', ':WakaTimeToday<CR>', { noremap = true, silent = true })

-- Manual LSP
if not vim.env.PYTHONPATH then
     vim.env.PYTHONPATH = '/opt/hfs20.0.653/houdini/python3.10libs/'
else
     vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ':/opt/hfs20.0.653/houdini/python3.10libs/'
end


local lspconfig = require("lspconfig")
local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

vim.api.nvim_create_autocmd("FileType", {
     pattern = "fish",
     callback = function()
          vim.fn.setenv("fish_lsp_show_client_popups", "false")

          local client_id = vim.lsp.start_client({
               name = "fish-lsp",
               cmd = { "fish-lsp", "start" },
               root_dir = lspconfig.util.find_git_ancestor(vim.fn.expand("%:p")) or vim.loop.os_homedir(),
               filetypes = { "fish" },
               single_file_support = true,
               autostart = true,
          })
          vim.lsp.buf_attach_client(0, client_id)
     end,
})

formatters.setup({
     { command = "fish_indent", filetypes = { "fish" } },
})

linters.setup({
     { command = "fish",       args = { "-n" },           filetypes = { "fish" } },
     { command = "shellcheck", filetypes = { "dosbatch" } },
})
