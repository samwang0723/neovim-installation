-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/samwang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/samwang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/samwang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/samwang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/samwang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  indentLine = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  nerdtree = {
    config = { "\27LJ\2\næ\1\0\0\3\0\n\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\b\0'\2\t\0B\0\2\1K\0\1\0\16set mouse=a\bcmd\n<tab>\28NERDTreeMapActivateNode\b‚îî NERDTreeDirArrowCollapsible\b‚îú\31NERDTreeDirArrowExpandable\6g\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/opt/nerdtree"
  },
  ["nerdtree-git-plugin"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/nerdtree-git-plugin"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\na\0\2\a\0\5\0\f6\2\0\0006\4\1\0009\4\2\0049\4\3\4\18\5\0\0'\6\4\0B\2\4\3\14\0\2\0X\4\2Ä+\4\2\0L\4\2\0L\3\2\0\15show_signs\21nvim_buf_get_var\bapi\bvim\npcallò\4\1\0\6\0\26\0+5\0\0\0005\1\1\0=\1\2\0003\1\3\0=\1\4\0007\0\5\0006\0\6\0009\0\a\0009\0\b\0006\1\6\0009\1\a\0019\1\n\0016\3\6\0009\3\a\0039\3\v\0039\3\f\0036\4\5\0B\1\3\2=\1\t\0006\0\6\0009\0\r\0009\0\14\0'\2\15\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\6\0009\0\r\0009\0\14\0'\2\15\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\22\0'\2\23\0B\0\2\0029\0\24\0009\0\25\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ngopls\14lspconfig\frequire\1\0\2\vsilent\2\fnoremap\0020<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]d\1\0\2\vsilent\2\fnoremap\0020<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[d\6n\20nvim_set_keymap\bapi\27on_publish_diagnostics\15diagnostic\twith$textDocument/publishDiagnostics\rhandlers\blsp\bvim\22diagnostic_config\nsigns\0\17virtual_text\1\0\1\fspacing\3\2\1\0\2\21update_in_insert\1\14underline\2\0" },
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-gitbranch"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/vim-gitbranch"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-kubernetes"] = {
    loaded = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/start/vim-kubernetes"
  },
  ["vim-one"] = {
    config = { "\27LJ\2\ny\0\0\3\0\5\0\r6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\1K\0\1\0\22set termguicolors\24set background=dark\20colorscheme one\bcmd\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/opt/vim-one"
  },
  ["vim-terraform"] = {
    loaded = true,
    needs_bufread = true,
    path = "/Users/samwang/.local/share/nvim/site/pack/packer/opt/vim-terraform"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vim-go
time([[Setup for vim-go]], true)
try_loadstring("\27LJ\2\nF\0\1\a\0\3\0\b6\1\0\0009\1\1\0019\1\2\1\18\3\0\0+\4\2\0+\5\2\0+\6\2\0D\1\5\0\27nvim_replace_termcodes\bapi\bvim£\1\0\0\6\0\b\2\0306\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\16Ä6\1\0\0009\1\1\0019\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0ç\1\0\0\3\2\6\1\0226\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\vÄ-\0\1\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0'\2\4\0D\0\2\0X\0\3Ä-\0\0\0'\2\5\0D\0\2\0K\0\1\0\0¿\1¿\15<C-x><C-o>\n<Tab>\n<C-n>\15pumvisible\afn\bvim\2`\0\0\3\1\5\1\0146\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\3Ä-\0\0\0'\2\4\0D\0\2\0K\0\1\0\0¿\n<C-h>\n<C-p>\15pumvisible\afn\bvim\2_\0\0\3\1\5\1\0146\0\0\0009\0\1\0009\0\2\0B\0\1\2\t\0\0\0X\0\4Ä-\0\0\0'\2\3\0D\0\2\0X\0\3Ä-\0\0\0'\2\4\0D\0\2\0K\0\1\0\0¿\t<CR>\n<C-y>\15pumvisible\afn\bvim\2Œ\6\1\0\b\0\"\0Q6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\1\0=\1\t\0006\0\0\0009\0\1\0)\1\1\0=\1\n\0006\0\0\0009\0\1\0)\1\0\0=\1\v\0006\0\0\0009\0\1\0)\1\0\0=\1\f\0003\0\r\0003\1\14\0006\2\15\0003\3\17\0=\3\16\0026\2\15\0003\3\19\0=\3\18\0026\2\15\0003\3\21\0=\3\20\0026\2\0\0009\2\22\0029\2\23\2'\4\24\0'\5\25\0'\6\26\0005\a\27\0B\2\5\0016\2\0\0009\2\22\0029\2\23\2'\4\24\0'\5\28\0'\6\29\0005\a\30\0B\2\5\0016\2\0\0009\2\22\0029\2\23\2'\4\24\0'\5\31\0'\6 \0005\a!\0B\2\5\0012\0\0ÄK\0\1\0\1\0\2\vsilent\2\fnoremap\2 <C-R>=v:lua.enter_key()<CR>\f<enter>\1\0\2\vsilent\2\fnoremap\2%<C-R>=v:lua.s_tab_complete()<CR>\f<s-tab>\1\0\2\vsilent\2\fnoremap\2#<C-R>=v:lua.tab_complete()<CR>\n<tab>\6i\20nvim_set_keymap\bapi\0\14enter_key\0\19s_tab_complete\0\17tab_complete\a_G\0\0\27go_template_autocreate\29go_gocode_propose_source\31go_highlight_generate_tags#go_highlight_build_constraints\29go_highlight_extra_types\27go_highlight_operators go_highlight_function_calls\27go_highlight_functions\24go_highlight_fields\23go_highlight_types\27go_diagnostics_enabled\6g\bvim\0", "setup", "vim-go")
time([[Setup for vim-go]], false)
-- Setup for: nerdtree
time([[Setup for nerdtree]], true)
try_loadstring("\27LJ\2\nw\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\28<cmd>NERDTreeToggle<cr>\n<C-f>\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "nerdtree")
time([[Setup for nerdtree]], false)
time([[packadd for nerdtree]], true)
vim.cmd [[packadd nerdtree]]
time([[packadd for nerdtree]], false)
-- Setup for: vim-one
time([[Setup for vim-one]], true)
try_loadstring("\27LJ\2\nU\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0K\0\1\0\bone\18airline_theme\22one_allow_italics\6g\bvim\0", "setup", "vim-one")
time([[Setup for vim-one]], false)
time([[packadd for vim-one]], true)
vim.cmd [[packadd vim-one]]
time([[packadd for vim-one]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\nŒ\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\"<cmd>Telescope find_files<cr>\15<leader>ff\1\0\1\fnoremap\2!<cmd>Telescope live_grep<cr>\15<leader>fg\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: vim-terraform
time([[Setup for vim-terraform]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\26terraform_fmt_on_save\6g\bvim\0", "setup", "vim-terraform")
time([[Setup for vim-terraform]], false)
time([[packadd for vim-terraform]], true)
vim.cmd [[packadd vim-terraform]]
time([[packadd for vim-terraform]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\na\0\2\a\0\5\0\f6\2\0\0006\4\1\0009\4\2\0049\4\3\4\18\5\0\0'\6\4\0B\2\4\3\14\0\2\0X\4\2Ä+\4\2\0L\4\2\0L\3\2\0\15show_signs\21nvim_buf_get_var\bapi\bvim\npcallò\4\1\0\6\0\26\0+5\0\0\0005\1\1\0=\1\2\0003\1\3\0=\1\4\0007\0\5\0006\0\6\0009\0\a\0009\0\b\0006\1\6\0009\1\a\0019\1\n\0016\3\6\0009\3\a\0039\3\v\0039\3\f\0036\4\5\0B\1\3\2=\1\t\0006\0\6\0009\0\r\0009\0\14\0'\2\15\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\6\0009\0\r\0009\0\14\0'\2\15\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\22\0'\2\23\0B\0\2\0029\0\24\0009\0\25\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ngopls\14lspconfig\frequire\1\0\2\vsilent\2\fnoremap\0020<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]d\1\0\2\vsilent\2\fnoremap\0020<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[d\6n\20nvim_set_keymap\bapi\27on_publish_diagnostics\15diagnostic\twith$textDocument/publishDiagnostics\rhandlers\blsp\bvim\22diagnostic_config\nsigns\0\17virtual_text\1\0\1\fspacing\3\2\1\0\2\21update_in_insert\1\14underline\2\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nerdtree
time([[Config for nerdtree]], true)
try_loadstring("\27LJ\2\næ\1\0\0\3\0\n\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\b\0'\2\t\0B\0\2\1K\0\1\0\16set mouse=a\bcmd\n<tab>\28NERDTreeMapActivateNode\b‚îî NERDTreeDirArrowCollapsible\b‚îú\31NERDTreeDirArrowExpandable\6g\bvim\0", "config", "nerdtree")
time([[Config for nerdtree]], false)
-- Config for: vim-one
time([[Config for vim-one]], true)
try_loadstring("\27LJ\2\ny\0\0\3\0\5\0\r6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\1K\0\1\0\22set termguicolors\24set background=dark\20colorscheme one\bcmd\bvim\0", "config", "vim-one")
time([[Config for vim-one]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-go'}, { ft = "go" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/samwang/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /Users/samwang/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /Users/samwang/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
