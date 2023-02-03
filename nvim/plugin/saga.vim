lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga{
    debug = true,
}
EOF


" code action
nnoremap <silent> <leader>ca :Lspsaga code_action<CR>
" show line diagnostic
nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
" show code coverage
nnoremap <silent> <leader>c <Plug>(go-coverage-toggle)<CR>
" test nearest testcase
nnoremap <silent> <leader>t :TestNearest<CR>
" test file
nnoremap <silent> <leader>tt :TestFile<CR>
" golang auto fill struct
nnoremap <silent> <leader>fs :GoFillStruct <CR>

" open diffview
nnoremap <silent> <leader>do :DiffviewOpen <CR>
" close diffview
nnoremap <silent> <leader>dc :DiffviewClose <CR>

" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh :Lspsaga lsp_finder<CR>

" show hover doc
nnoremap <silent> hh :Lspsaga hover_doc<CR>

" rename parameter
nnoremap <silent> rn :Lspsaga rename<CR>

" jump diagnostic
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" show signature help
nnoremap <silent> gs :Lspsaga signature_help<CR>

" split screen vertical
nnoremap <silent> vs :vsplit<CR>

" split screen hiorzontal
nnoremap <silent> hs :split<CR>

" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <F7> :Lspsaga open_floaterm<CR>
tnoremap <silent> <F6> <C-\><C-n>:Lspsaga close_floaterm<CR>

" show whichkey
nnoremap <silent> " :WhichKey<CR>

