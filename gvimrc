colorscheme greenland

highlight TabString ctermbg=red guibg=#222222
au BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
au WinEnter * let w:m2 = matchadd("TabString", '^\t+')

highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

highlight WhitespaceEOL ctermbg=red guifg=#A52222 guibg=NONE
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"hi CursorLine term=bold cterm=bold guibg=Gray30

" for ime bug
set noimdisable
set iminsert=2

set cursorline
set cursorcolumn

set guifont=Ricty\ Discord:h21

set listchars=tab:\|\ ,trail:␣,eol:⏎

