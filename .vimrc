" If you don't understand a setting in here, just type ':h setting'.

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set encoding=utf-8

" Leader
let mapleader = " "

" set backspace=2   " Backspace deletes like most programs in insert mode
set backspace=indent,eol,start " Make backspace behave in a sane manner.
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline

" Switch syntax highlighting on
syntax on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

filetype off                  " required

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

" ALE linting events
augroup ale
  autocmd!

  if g:has_async
    autocmd VimEnter *
      \ set updatetime=1000 |
      \ let g:ale_lint_on_text_changed = 0
    autocmd CursorHold * call ale#Queue(0)
    autocmd CursorHoldI * call ale#Queue(0)
    autocmd InsertEnter * call ale#Queue(0)
    autocmd InsertLeave * call ale#Queue(0)
  else
    echoerr "The thoughtbot dotfiles require NeoVim or Vim 8"
  endif
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Line numbers
set relativenumber
if v:version > 703
  set number " hybrid relative and absolute for current line
endif

" Colorscheme
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized
highlight ColorColumn ctermbg=DarkCyan
set guifont=Mnlo\ Regular:h14

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" ctrlp
" =====

" Make CtrlP use ag for listing the files. Way faster and no useless files.
" Without --hidden, it never finds .travis.yml since it starts with a dot
" let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
" let g:ctrlp_use_caching = 0
"
" Enable MRU for CtrlP
" let g:ctrlp_cmd = 'CtrlP'

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
if &diff
    set diffopt-=internal
    set diffopt+=iwhite
endif

" vim-rspec
" ==========

" Use iTerm instea of Terminal for vim-rspec
" let g:rspec_runner = "os_x_iterm"

" vim-test
" ========
"
" Use iTerm to execute test commands
if has("gui_running")
  let test#strategy = "iterm"
  let g:test#preserve_screen = 1
else
  let test#strategy = "kitty"
  " let test#strategy = "neoterm"
  " let g:neoterm_default_mod = "botright"
  " let g:neoterm_keep_term_open = 0  " when buffer closes, exit the terminal too.
  " let g:neoterm_autoscroll = 1      " autoscroll to the bottom when entering insert mode
  " let g:neoterm_size = 10

  " let test#strategy = "neovim"
  " let test#neovim#term_position = "botright 10"

  " if $IN_NIX_SHELL
  "   let test#strategy = "neoterm"
  "   let g:neoterm_default_mod = "botright"
  "   let g:neoterm_keep_term_open = 0  " when buffer closes, exit the terminal too.
  "   let g:neoterm_autoscroll = 1      " autoscroll to the bottom when entering insert mode
  "   let g:neoterm_size = 10
  " else
  "   let test#strategy = "neovim"
  "   let test#neovim#term_position = "botright 10"
  " endif
end

" direnv
" ======
" let g:direnv_auto = 1

" RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>r :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" vim-test mappings
nmap <silent> <leader>r :TestNearest<CR>
nmap <silent> <leader>rr :Tclose<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>gt :TestVisit<CR>

" vim-rubytest mappings
" map <Leader>r <Plug>RubyTestRun
" map <Leader>t <Plug>RubyFileRun
" map <Leader>l <Plug>RubyTestRunLast

" vim-run-interactive mappings
nnoremap <leader>ri :RunInInteractiveShell<space>

" Key mappings
" :inoremap ii <Esc>

" split term mappings
nmap <silent> <leader>f :10Term<CR>

" vim-fugitive Git mappings
nnoremap <leader>gb <cmd>Git blame<cr>

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fgg <cmd>Telescope git_commits<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgb <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" File Explorer
nnoremap <leader>b <cmd>NERDTree<cr>

" Run elixir formatter on save
let g:mix_format_on_save = 1
let g:mix_format_options = '--check-equivalent'
let g:mix_format_silent_errors = 1

" Go formatter
let g:go_fmt_command = "gofmt"

" Spell checking
set spellfile=$HOME/.vim-spell-en.utf-8.add
autocmd BufRead,BufNewFile *.md setlocal spell

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

set mouse=a
set clipboard=unnamed

set nohlsearch

" Telescope Setup
lua << EOF
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    },
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
  },
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
