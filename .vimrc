" ~/.vimrc

" To ignore plugin indent changes, instead use:
"filetype plugin on

set encoding=utf-8 fileencodings=
syntax on

set number relativenumber
set cc=80

autocmd Filetype make setlocal noexpandtab

set list listchars=tab:»·,trail:·


" per .git vim configs
" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository
" change syntax settings for this repository
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
set clipboard=unnamedplus


"""""""""""""""""""""""
"" Add new plugins here
"""""""""""""""""""""""
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'yuttie/hydrangea-vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"""Plugin 'justmao945/vim-clang'
"""Plugin 'OmniCppComplete'
"""""""""""""""""""""""
"" End of plugin list
"""""""""""""""""""""""
call plug#end()


filetype plugin indent on 
colorscheme hydrangea

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
autocmd vimenter * hi NonText guibg=NONE ctermbg=NONE
autocmd vimenter * hi LineNr guibg=NONE ctermbg=NONE
autocmd vimenter * hi Comment guibg=NONE ctermbg=NONE
autocmd vimenter * hi CursorLine guibg=NONE ctermbg=NONE

"let g:airline_theme='onedark'
" let g:airline_theme = 'codedark'
 let g:molokai_original = 1
" let g:rehash256 = 1

"""""""""""""""""""""""
"" Map functions
"""""""""""""""""""""""
syntax on


set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent
set incsearch
set cursorline
set backspace=indent,eol,start

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="John Doe <john@doe.com>"
let g:omni_sql_no_default_maps = 1

" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <expr> <F2> pumvisible() ? '<C-y><ESC>:w<CR>a' : '<ESC>:w<CR>a'
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" goto definition with F12
map <F12> <C-]>

autocmd Filetype  {cs,py,c,cpp,h} call SetCSharpAutocompletion()
function SetCSharpAutocompletion()
  inoremap {      {}<Left>
  inoremap {<CR>  <CR>{<CR>}<Esc>O
  inoremap {{     {
  inoremap {}     {}

  inoremap (  ()<Left>
  inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
  inoremap <expr> <BS>  strpart(getline('.'), col('.')-2, 2) == "()" ? "\<BS><Del>" : strpart(getline('.'), col('.')-2, 2) == "''" ? "\<BS><Del>" : strpart(getline('.'), col('.')-2, 2) == "\"\"" ? "\<BS><Del>" : "\<BS>"


  inoremap [  []<Left>
  inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

  inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
  inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
"  inoremap <expr> <BS>  strpart(getline('.'), col('.')-2, 2) == "''" ? "\<BS><Del>" : "\<BS>"

"  inoremap <expr> ; strpart(getline('.'), col('.')-1, 1) == ")" ? "\<End>;" : ";"

  inoremap for<Space> for ()<Left>
  inoremap if<Space> if ()<Left>
  inoremap if<Tab> if ()<Left>
endfunction

""" OmniSharp shortcuts
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

inoremap <expr> <CR> pumvisible() ? (complete_info().selected == -1 ? '<C-y><CR>' : '<C-y>') : '<CR>'

inoremap <esc> <esc>:w<cr>

inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
 inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
