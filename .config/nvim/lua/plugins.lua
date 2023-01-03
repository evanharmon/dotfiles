local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Pre-reqs for other plugins
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-dap'
  -- My plugins here
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('nvim-tree').setup {} end
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  use {
    'folke/tokyonight.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function() require('tokyonight').setup({
        style = 'night',
        sidebars = { 'terminal', 'packer' },
        on_highlights = function(hl, c)
          local prompt = '#2d3149'
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark, }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark, }
          hl.TelescopePromptNormal = { bg = prompt, }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt, }
          hl.TelescopePromptTitle = { bg = prompt, fg = prompt, }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark, }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark, }
        end,
      })
    end
  }
  use { 'mrjones2014/dash.nvim', run = 'make install', }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { {'nvim-telescope/telescope-fzf-native.nvim'}, {'nvim-lua/plenary.nvim'}, {'mrjones2014/dash.nvim'} }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Auto Completion framework:
  use 'hrsh7th/nvim-cmp' 
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/cmp-path',                              
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    after = {'hrsh7th/nvim-cmp'},
    require = {'hrsh7th/nvim-cmp'}
  }
  -- Useful completion sources:
  use 'hrsh7th/vim-vsnip' 
  -- Language Specific
  use 'simrat39/rust-tools.nvim'
  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('crates').setup() end
  }
  -- Helper plugins
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  -- maybe try noice instead?
  use {
    'j-hui/fidget.nvim',
    config = function () require('fidget').setup {} end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

