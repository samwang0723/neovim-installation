lua require('plugins')
lua require('keybindings')
lua require('options')

set updatetime=10 " Short updatetime so the CursorHold event fires fairly often
function! HighlightWordUnderCursor()
  if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
    exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
  else
    match none
  endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

hi Visual  guifg=White guibg=#61afef gui=none

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

if !isdirectory($HOME . "/.local/share/nvim/site/undodir")
  call mkdir($HOME . "/.local/share/nvim/site/undodir", "p")
endif

syntax on
set number relativenumber
set nowrap
set undofile
set undodir=~/.local/share/nvim/site/undodir
set clipboard=unnamed
set backspace=indent,eol,start
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
set ignorecase
set incsearch
set smartcase
set hlsearch!
set wildmode=longest,list,full
set completeopt=longest,menuone
set exrc
set secure
set autoread
set termguicolors
set list lcs=tab:\¦\ 
set wildmode=longest,list,full

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" When switching panes in tmux, an escape sequence is printed. Redrawing gets
" rid of it. See https://gist.github.com/mislav/5189704#comment-951447
au FocusLost * :redraw!

" each language using different tab settings
" ts = 'number of spaces that <Tab> in file uses' 
" sts = 'number of spaces that <Tab> uses while editing' 
" sw = 'number of spaces to use for (auto)indent step'

autocmd FileType go setlocal ts=8 sts=8 sw=8
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tf setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType py setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType rb setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
" support css word with -
autocmd FileType css,scss,slim,html,eruby,coffee,javascript,wxml setlocal iskeyword+=-
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4

autocmd BufNewFile,BufRead *.slim set filetype=slim
autocmd BufNewFile,BufRead *.es6 set filetype=javascript
autocmd BufNewFile,BufRead *.json.jb set filetype=ruby
autocmd BufNewFile,BufRead *.wxml set filetype=xml
autocmd BufNewFile,BufRead *.wxss set filetype=css

" lightline
set laststatus=2
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2

" json format
"au FileType json autocmd BufWritePost *.json execute '%!python -m json.tool' | w

" gitgutter
set updatetime=100
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" ruby on rails
" gem install gem-ctags
" gem ctags
let g:rails_ctags_arguments = ['--languages=ruby --exclude=.git --exclude=log .']
let g:vim_markdown_folding_disabled = 1

" prettier
let g:prettier#autoformat = 0
let g:prettier#config_file = '~/.prettierrc.yml'
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md,*.go,*.rb,*.sh PrettierAsync

" auto-formatting
autocmd BufWritePre * lua vim.lsp.buf.format { async = true }
autocmd BufWritePre *.go.in lua vim.lsp.buf.format { async = true }
autocmd BufWritePre *.go lua goimports(1000)

fun! GoFumpt()
  :silent !gofumpt -w %
  :edit
endfun

autocmd BufWritePost *.go call GoFumpt()

" avoid Tab autocomplete conflict with copilot accept
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:gotests_bin = '/Users/samwang/Workspace/bin/gotests'
