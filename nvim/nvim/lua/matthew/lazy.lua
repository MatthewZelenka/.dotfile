local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        -- Git related plugins
        'tpope/vim-fugitive',

        -- Fuzzy Finder (files, lsp, etc)
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- Fuzzy Finder Algorithm which requires local dependencies to be built.
                -- Only load if `make` is available. Make sure you have the system
                -- requirements installed.
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    -- NOTE: If you are having trouble with this installation,
                    --       refer to the README for telescope-fzf-native for more instructions.
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
            },
        },

        -- lsp
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            dependencies = {
                --- Uncomment these if you want to manage LSP servers from neovim
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- LSP Support
                {'neovim/nvim-lspconfig'},
                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'L3MON4D3/LuaSnip'},
            }
        },

        -- Tree style error messages
        'ErichDonGubler/lsp_lines.nvim',

        -- Highlight, edit, and navigate code
        {
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                'nvim-treesitter/nvim-treesitter-textobjects',
                -- Treesitter exstension
                'nvim-treesitter/playground',
            },
            build = ':TSUpdate',
        },

        -- Undo your mistakes with branchs
        'mbbill/undotree',

        -- Fancy tabs lol
        'theprimeagen/harpoon',

        -- Color scheme
        {
            'rose-pine/neovim',
            name = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        }
    }
)
