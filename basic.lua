local laminepath = vim.env.Lamine
return {
  'tpope/vim-surround',
  'cloudhead/neovim-fuzzy',
  'morhetz/gruvbox',
  'preservim/nerdtree',
  -- { 'echasnovski/mini.test', version = '*' },
  {"nvim-lua/plenary.nvim", lazy=true},
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   }
  -- },
  'tpope/vim-commentary',

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
  { dir = laminepath },
}
