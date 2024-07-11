call plug#begin()

" List your plugins here
" install telescope and dependencies 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-tree/nvim-web-devicons'
" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'aspeddro/pandoc.nvim'
Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }
call plug#end()

set spelllang=en_us
set spell
