lua require('plugins')
"lua require("lsp_config")

"autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
"autocmd BufWritePre *.go lua goimports(1000)

set updatetime=10 " Short updatetime so the CursorHold event fires fairly often
function! HighlightWordUnderCursor()
  if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
    exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
  else
    match none
  endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

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
autocmd FileType py setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
