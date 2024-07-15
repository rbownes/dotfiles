-- Ensure packer.nvim is loaded
vim.cmd [[packadd packer.nvim]]

-- Initialize packer.nvim and define plugins
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- List your plugins here
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.8'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'nvim-tree/nvim-web-devicons'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'aspeddro/pandoc.nvim'
  use {'shortcuts/no-neck-pain.nvim', tag = '*'}
  
  -- Add themes
  use 'folke/tokyonight.nvim'
  use 'habamax/vim-habamax'
end)

-- Set spell checking options (uncomment if needed)
-- vim.opt.spelllang = 'en_us'
-- vim.opt.spell = true

-- nvim-treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
}

-- Configure <CR> (Enter) to confirm completion with coc.nvim
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], { noremap = true, expr = true, silent = true })

-- coc.nvim configuration for marksman LSP
vim.cmd [[
  augroup coc_user_config
    autocmd!
    autocmd FileType markdown setlocal formatexpr=CocAction('formatSelected')
  augroup end
]]

-- Set colorscheme (add your preferred colorscheme)
vim.cmd [[
  try
    colorscheme tokyonight
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme habamax
  endtry
]]
