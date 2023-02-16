## packer.nvim installation

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## CTags installation

```
brew install gotags
brew install ctags-exuberant
```

## Neovim Configuration

- Create folder under ~/.config/nvim to store init.vim and lua/ Packer configuration.
- Launch any file using nvim and run `PackerSync`

### Packer

Packer https://github.com/wbthomason/packer.nvim

```
-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
-- Regenerate compiled loader file
:PackerCompile
-- Remove any disabled or unused plugins
:PackerClean
-- Clean, then install missing plugins
:PackerInstall
-- Clean, then update and install plugins
:PackerUpdate
-- Perform `PackerUpdate` and then `PackerCompile`
:PackerSync
-- Loads opt plugin immediately
:PackerLoad completion-nvim ale
```

### Replace/Modify multi-line strings

```
%s/{source}/{replacement}/p
---
select the first caracter of your block
press Ctrl+V ( this is rectangular visual selection mode)
type j for each line more you want to be commented
type Shift-i (like I for "insert at start")
type // (or # or " or ...)
you will see the modification appearing only on the first line
IMPORTANT LAST STEP: type Esc key
```

### Split window

```
:vsplit
Ctrl+w - go to the window above the selected window
```

### Nvim-lspconfig debugging

```
:messages
:lua print(vim.inspect(vim.lsp.buf_get_clients()))
:LspInfo
```

### Useful keybindings

```
\fg - live grep
\ff - find files
F7/F6 - open/Clos inner terminal
F8 - code tags
gh - lsp finder
gi - implementation
gD - declaration
gd - goto definition
gs - signature help
gr - references
rn - rename
pd - preview definition
<space>D - type definition
\ca or ga - code actions
\cd - show line diagnostics
\cc - show cursor diagnostics
[e - diagnostics jump to next
]e - diagnostics jump to prev
ff - formatting
<tab> - autocomplete
Ctrl+o - godef back
---
press <v> to go to the “Visual Mode” of VIM and select the substring and press <y>. The text should be copied.
press <p> to paste
press <dd> to delete the selected range
```

## Install Language Server

### Markdown

1. Download from https://github.com/artempyanykh/marksman/releases
2. Move the binary file into /usr/local/bin

```
$ mv marksman-macos marksman && chmod +x marksman
```

### Lua

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua

### Solargraph (Ruby on Rails)

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph

### tsserver

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver

### dockerls

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls

### html

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

### cssls

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls

### gopls

https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
