

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a 				" Enable mouse
set tabstop=4 				" 
set shiftwidth=4 			" 
set listchars=tab:\¦\ 		" Tab charactor 
set list
set foldmethod=indent 		" 
set foldlevelstart=99 		"  
set number 					" Show line number
set ignorecase 				" Enable case-sensitive 

" Disable backup
set nobackup
set nowb
set noswapfile

syntax on

" Enable copying from vim to clipboard
if has('win32')
	set clipboard=unnamed  
else
	set clipboard=unnamedplus
endif

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
			\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime 
			\ | endif
autocmd FileChangedShellPost *
			\ echohl WarningMsg
			\ | echo "File changed on disk. Buffer reloaded."
			\ | echohl None


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Resize pane
nmap <M-Right> :vertical resize +1<CR> 		
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>

" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used for Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')
" Theme
Plug 'joshdick/onedark.vim', 					" Dark theme
Plug 'projekt0n/github-nvim-theme'

Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" File browser
Plug 'preservim/nerdTree' 						" File browser  
Plug 'Xuyuanp/nerdtree-git-plugin' 				" Git status
Plug 'ryanoasis/vim-devicons' 					" Icon
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'unkiwii/vim-nerdtree-sync' 				" Sync current file 
" Auto save wordspace 
Plug 'thaerkh/vim-workspace'
Plug  'xolox/vim-session'
Plug 'xolox/vim-misc'
" COMMENT CODE
Plug 'terrortylor/nvim-comment'
" File search
Plug 'junegunn/fzf', 
			\ { 'do': { -> fzf#install() } } 			" Fuzzy finder 
Plug 'junegunn/fzf.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Terminal
Plug 'voldikss/vim-floaterm' 					" Float terminal

" Code intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server 
Plug 'jiangmiao/auto-pairs' 					" Parenthesis auto 
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim' 
Plug 'preservim/nerdcommenter' 					" Comment code 
"Plug 'liuchengxu/vista.vim' 					" Function tag bar 
Plug 'alvan/vim-closetag' 						" Auto close HTML/XML tag 

" Code syntax highlight
Plug 'yuezk/vim-js' 							" Javascript
Plug 'MaxMEllon/vim-jsx-pretty' 				" JSX/React
Plug 'jackguo380/vim-lsp-cxx-highlight'			" C++ syntax
Plug 'uiiaoo/java-syntax.vim' 					" Java

" AutoSave
Plug 'Pocco81/AutoSave.nvim'
Plug 'kevinoid/vim-jsonc'

" Debugging
Plug 'puremourning/vimspector' 					" Vimspector

" Source code version control
Plug 'tpope/vim-fugitive' 						" Git
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set theme 
colorscheme onedark

" Overwrite some color highlight
if (has("autocmd"))
	augroup colorextend
		autocmd ColorScheme 
					\ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
		autocmd ColorScheme 
					\ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
	augroup END
endif

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufRead,BufNewFile *.mycjson set filetype=jsonc
autocmd FileType json syntax match Comment +\/\/.\+$+


" Other setting
for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
	execute 'source' setting_file
endfor

lua << EOF
local autosave = require("autosave")

autosave.setup({
enabled = true,
execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
events = {"InsertLeave", "TextChanged"},
conditions = {
	exists = true,
	filename_is_not = {},
	filetype_is_not = {},
	modifiable = true
	},
write_all_buffers = false,
on_off_commands = true,
clean_command_line_interval = 0,
debounce_delay = 135
})
local comment = require('nvim_comment')
comment.setup({
-- Linters prefer comment and line to have a space in between markers
marker_padding = true,
-- should comment out empty or whitespace only lines
comment_empty = true,
-- Should key mappings be created
create_mappings = true,
-- Normal mode mapping left hand side
line_mapping = "gcc",
-- Visual/Operator mapping left hand side
operator_mapping = "gc",
-- Hook function to call before commenting takes place
hook = nil
})

EOF
nnoremap <leader>so :OpenSession 
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>
" d

:let g:session_autoload = 'yes'
:let g:session_autosave = 'yes'
