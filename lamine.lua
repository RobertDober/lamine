local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local laminepath = vim.env.Lamine
-- local viminepath = vim.fn.stdpath("data") .. "/site/vimine"
-- print("viminepath= ".. viminepath)
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

vim.g.mapleader = ";"

require'lazy'.setup( {
  -- {
  --   'mrcjkb/haskell-tools.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim', -- Optional
  --   },
  --   branch = '2.x.x', -- Recommended
  --   init = function() -- Optional, see Advanced configuration
  --     -- vim.g.haskell_tools = {
  --     --   -- ...
  --     -- },
  --   end,
  --   ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' }
  -- },
  {
    -- Absolutely necessary
    -- --------------------
    'tpope/vim-surround',
    'cloudhead/neovim-fuzzy',
    'morhetz/gruvbox',
    'preservim/nerdtree',
    'tpope/vim-commentary',
    -- 'SeniorMars/typst.nvim',
    'kaarmu/typst.vim',
    { dir = laminepath },

    -- Nice to have
    -- ------------
    'godlygeek/tabular',
    'ludovicchabant/vim-gutentags',
    -- 'leafo/moonscript-vim',
    --
    -- LSP WIP
    -- -------------------
    -- 'nvim-treesitter/nvim-treesitter',
    -- 'neovim/nvim-lspconfig',
    -- { 'mihyaeru21/nvim-ruby-lsp', requires = 'neovim/nvim-lspconfig' },
    -- 'autozimu/LanguageClient-neovim',

    -- Colorschemes
    -- ------------
    -- 'EdenEast/nightfox.nvim',
    'endel/vim-github-colorscheme',
    'lifepillar/vim-solarized8',
    'folke/tokyonight.nvim',
    'sainnhe/everforest',
    'elixir-editors/vim-elixir',
    'catppuccin/nvim',
    'EdenEast/nightfox.nvim',

    -- 'flazz/vim-colorschemes'
    -- 'godlygeek/tabular',
    -- 'hrsh7th/nvim-compe',
    -- 'hrsh7th/vim-vsnip',
    -- 'liuchengxu/graphviz.vim',
    -- 'mracos/mermaid.vim',
    -- 'neovim/nvim-lspconfig',
    -- 'tpope/vim-fugitive',
    -- 'zah/nim.vim',
    --
    -- For Rust
    -- ------------

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',

  }
})

-- require'treesitter-config'
-- require'lspconfig-config'
