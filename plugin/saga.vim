lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga() 
EOF

" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
" or use command LspSagaFinder
nnoremap <silent> gh :Lspsaga lsp_finder<CR>

" code action
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" or use command
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

" show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" or use command
nnoremap <silent>K :Lspsaga hover_doc<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" rename
nnoremap <silent>rn <cmd>lua require('lspsaga.rename').rename()<CR>
" or command
nnoremap <silent>rn :Lspsaga rename<CR>
" close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`

" preview definition
nnoremap <silent> pd <cmd>lua require('lspsaga.provider').preview_definition()<CR>
" or use command
nnoremap <silent> pd :Lspsaga preview_definition<CR>

" show
nnoremap <silent><leader>cd <cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>
nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
" only show diagnostic if cursor is over the area
nnoremap <silent><leader>cc <cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>

" jump diagnostic
nnoremap <silent> [e <cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>
" or use command
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" or command
nnoremap <silent> gs :Lspsaga signature_help<CR>

" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <F7> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR> 
" or open_float_terminal('lazygit')<CR>
tnoremap <silent> <F6> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
" or use command
nnoremap <silent> <F7> :Lspsaga open_floaterm<CR>
tnoremap <silent> <F6> <C-\><C-n>:Lspsaga close_floaterm<CR>i
