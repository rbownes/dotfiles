-- Initialize packer.nvim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- List your plugins here
  -- Install telescope and dependencies
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.8'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'nvim-tree/nvim-web-devicons'
  
  -- Use release branch (recommended)
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'aspeddro/pandoc.nvim'
  use {'shortcuts/no-neck-pain.nvim', tag = '*'}
end)

-- Set spell checking options
-- vim.opt.spelllang = 'en_us'
-- vim.opt.spell = true
