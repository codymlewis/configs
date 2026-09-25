vim.pack.add{
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/chentoast/marks.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/mfussenegger/nvim-dap-python",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/Julian/lean.nvim",
    "https://github.com/scottmckendry/cyberdream.nvim"
}

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", load = true },
})

vim.o.history = 500
vim.o.autoread = true
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_command [[checktime]]
    end,
    group = vim.api.nvim_create_augroup("Detect file changes", { clear = true }),
})

vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.magic = true
vim.o.wildmenu = true
vim.o.background = 'dark'
vim.o.encoding = 'utf8'
vim.o.swapfile = false
vim.o.title = true
vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.number = true
vim.wo.lbr = true
vim.wo.wrap = true

vim.bo.tabstop = 8
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.undofile = true

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

vim.g.lean_config = { mappings = true, }

vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = { '*.tex', '*.bib', '*.md', '*.txt' },
    callback = function()
        vim.opt_local.spell = true
    end,
    group = vim.api.nvim_create_augroup("Enable spell checking", { clear = true }),
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_command [[%s/\s\+$//e]]
    end,
    group = vim.api.nvim_create_augroup("Clean trailing spaces", { clear = true }),
})

vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost'}, {
    pattern = { '*.py', '*.c', '*.h', '*.cpp', '*.hpp', '*.rs', '*.tex', '*.bib', '*.lua', '*.sh', '*.lean', '*.toml', 'Dockerfile' },
    callback = function()
        vim.api.nvim_command [[write]]
    end,
    group = vim.api.nvim_create_augroup("Autosave buffer", { clear = true }),
})

vim.api.nvim_set_keymap('n', '<Space>', "", {})
vim.g.mapleader = ' '
vim.g.maplocalleader = '  '

options = { noremap = true }
vim.api.nvim_set_keymap('n', '<leader>s', ':setlocal spell!<cr>', options)
vim.api.nvim_set_keymap('n', '<leader>e', ':Explore<cr>', options)
vim.api.nvim_set_keymap('n', '<leader>t', ':vsplit term://zsh<cr>', options)
vim.api.nvim_set_keymap('n', '<s-tab>', ':bprevious<cr>', options)
vim.api.nvim_set_keymap('n', '<tab>', ':bnext<cr>', options)

vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, options)
vim.keymap.set('n', '<leader>c', function() require('dap').continue() end, options)
vim.keymap.set('n', '<leader>i', function() require('dap').step_into() end, options)
vim.keymap.set('n', '<leader>o', function() require('dap').step_over() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dd', function() require('dap').disconnect() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dr', function() require('dap').repl.open() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dh', function() require('dap.ui.widgets').hover() end, options)
vim.keymap.set({'n', 'v'}, '<leader>dp', function() require('dap.ui.widgets').preview() end, options)
require("dap-python").setup("uv")

vim.keymap.set('n', '<leader>g', function() require('neogit').open() end, options)

vim.keymap.set("n", ";", "gcc", { remap = true })
vim.keymap.set("v", ";", "gc", { remap = true })

require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}
require("nvim-treesitter").install{ "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "rust", }

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "rust" },
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
    end,
})


local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = "nvim_lsp" },
        { name = "buffer" },
    },

    mapping = {
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },

    preselect = cmp.PreselectMode.None,

    completion = {
        completeopt = vim.o.completeopt,
    },
})

require("mason").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
    'tsserver',
    'jsonls',
    'eslint',
    'ruff',
    'pyright',
    'rust_analyzer',
    'clangd',
    'harper_ls',
    'docker_language_server',
}
for _, server in pairs(servers) do
    vim.lsp.config(server, { capabilities = capabilities, })
    vim.lsp.enable(server)
end

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})
vim.lsp.inline_completion.enable()

require('marks').setup()

require('nvim-autopairs').setup()

require("ibl").setup{
    indent = { char = "┊" },
}

require("gitsigns").setup()
require("neogit").setup{}

require('lualine').setup{
    options = { theme = 'codedark', }
}

vim.api.nvim_command [[colorscheme cyberdream]]
