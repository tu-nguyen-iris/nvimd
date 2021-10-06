" Vim Script
" Example config in VimScript
let g:github_function_style = "italic"
let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
" let g:github_colors = {
 \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

" Load the colorscheme
" colorscheme github_dark_default
 " VimScript
let g:github_comment_style = "italic"
let g:github_keyword_style = "italic"
let g:github_function_style = "italic"
let g:github_variable_style = "italic"

" Set theme 
" colorscheme onedark
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

if (has('termguicolors'))
  set termguicolors
endif
let g:airline_theme = 'material'
let g:material_theme_style = 'darker-community' 
colorscheme material


 " let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
