local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
g.mapleader=' '

-- ORDER MATTERS
require('plugins')
require('mason').setup()
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})
require("mason-lspconfig").setup({
  -- asm_lsp currently has a bug with cargo nightly
  -- had to install codelldb manually thru :Mason
  ensure_installed = { "bashls", "clangd", "cmake", "cssls", "dockerls", "emmet_ls", "gopls", "html", "jedi_language_server", "jsonls", "marksman", "rust_analyzer", "sqlls", "sumneko_lua", "taplo", "tsserver" }
})

-- set termguicolors to enable highlight groups
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
opt.termguicolors = true
require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "c", "cmake", "cpp", "css", "diff", "dockerfile", "go", "help", "html", "javascript", "jsdoc", "json", "lua", "make", "markdown", "ninja", "proto", "python", "rust", "scss", "sql", "toml", "tsx", "typescript", "vim" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
    { name = 'crates'},                             -- source for rust crates
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        inlayHints = { locationLinks = true },
      },
    }
  },
})
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    dash = {}
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

-- TODO set providers
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Settings
-- commented out blocks are from old config, turn on as needed
--[[
set rtp+=expand("$HOME/.fzf")
set rtp+=/usr/local/opt/fzf
set rtp+=expand("$HOME/.fnm")
set path+=**  " Recursive find
set path+=~/JUCE/modules
set shell=/bin/zsh
set tags+=~/JUCE/modules/tags
set nofoldenable
set mouse=r
set nomodeline
set conceallevel=1
--]]

cmd([[
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/dist/*	" OSX/Linux
set backspace=indent,eol,start
set encoding=utf8
set secure
set hidden
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set number relativenumber
set ruler
set autowrite
set splitbelow
set splitright
set undolevels=100
set undodir=~/.config/nvim/undodir
set formatoptions+=o
set nobackup nowritebackup noswapfile autoread
set hlsearch incsearch ignorecase smartcase
set wildmenu
set clipboard+=unnamed,unnamedplus
set showcmd
set showmatch
set showmode
set scrolloff=1
set sidescrolloff=5
set colorcolumn=+1
set linespace=0
set nojoinspaces
set display+=lastline
set timeoutlen=500
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set scrollback=100000
set shiftround

colorscheme tokyonight-night
]])

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
opt.completeopt = {'menuone', 'noselect', 'noinsert'}
opt.shortmess = vim.opt.shortmess + { c = true}
api.nvim_set_option('updatetime', 300) 

-- treesitter Folding - I don't use folding yet
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- formatting
cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- OLD maps
-- nnoremap <leader>= <C-w>=
-- nnoremap <ESC> :noh<return><ESC>
-- nnoremap <bar> <C-w><bar>
-- nnoremap <ESC> :noh<return><ESC>
-- nnoremap <leader><leader> <c-^>
-- nnoremap <bar> <C-w><bar>
-- nnoremap <Left> :vertical resize -1<CR>
-- nnoremap <Right> :vertical resize +1<CR>
-- nnoremap <Up> :resize -1<CR>
-- nnoremap <Down> :resize +1<CR>
-- imap <up> <nop>
-- imap <down> <nop>
-- imap <left> <nop>
-- imap <right> <nop>
-- " if on iterm2, add key pref for CTRL-H in prefs,
-- " action send escape sequence, type in [104;5u
-- nnoremap _ <C-w>_
-- " Open file under cursor in vertical split
-- nnoremap gf :vertical wincmd f<CR>

-- keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>w', "<cmd>w<cr>", { silent = true, remap = false })
vim.keymap.set('n', '<leader>q', "<cmd>q<cr>", { silent = true, remap = false })
vim.keymap.set('n', '<leader>=', "<C-w>=", { silent = true , remap = false })
-- windows
vim.keymap.set('n', '<leader><leader>', "<C-^>", { silent = true , remap = false }) -- swap to previous buffer
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true, remap = false }) -- switch to left split
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true, remap = false }) -- switch to right split
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true, remap = false }) -- switch to top split
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true, remap = false }) -- switch to bottom split
-- plugins
vim.keymap.set('n', '<leader>ntt', ":NvimTreeToggle<CR>", { silent = true , remap = false }) -- swap to previous buffer
