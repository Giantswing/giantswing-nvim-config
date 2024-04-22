" set guifont=Hack\ Nerd\ Font\ Bold30
" set guifont=FiraCode\ Nerd\ Font:h11
" set guifont=Hack,Noto_Color_Emoji:h12:b
" set linespace=1.2
let g:neovide_refresh_rate=60
let g:neovide_transparency=0.9
let g:neovide_no_idle=v:false
let g:neovide_show_border = v:true
let g:neovide_fullscreen=v:true
let g:neovide_cursor_animation_length = 0 "0.13"
let g:neovide_scroll_animation_length = 0 "0.3"
let g:neovide_cursor_trail_size = 0 "0.8"
let g:neovide_unlink_border_highlights = v:false

" " Set GUI Options 

" " Enable Mouse
" set mouse=a
"
" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    "GuiFont! CaskaydiaCove\ NFM:h14
    GuiFont! JetBrainsMonoNL\ NFM\ Medium:h11:w57
    GuiLinespace 0
endif
" " Disable GUI Tabline
" if exists(':GuiTabline')
"     GuiTabline 0
" endif
"
" " Disable GUI Popupmenu
" if exists(':GuiPopupmenu')
"     GuiPopupmenu 0
" endif
"
" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif
"
" " Right Click Context Menu (Copy-Cut-Paste)
" nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
" inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
" xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
" snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
