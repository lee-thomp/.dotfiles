set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Snippet Engine
Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" Indent Plugin
Plugin 'Yggdroot/indentLine'

" C/C++ Syntax Highlight Plugin
Plugin 'bfrg/vim-cpp-modern'
let g:cpp_member_highlight = 1

" Markdown Preview
Plugin 'iamcco/markdown-preview.nvim' 

" Markdown Syntax
Plugin 'preservim/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" Rainbow braces
Plugin 'frazrepo/vim-rainbow'
let g:rainbow_active = 1

" PowerShell Syntax
Plugin 'PProvost/vim-ps1'

" Python completion
Plugin 'davidhalter/jedi-vim'
let g:jedi#show_call_signatures = "2"

" Slime
Plugin 'kovisoft/slimv'

call vundle#end()
filetype plugin indent on

" Line wrap, don't clip words
set wrap linebreak

" 4-wide tabs
set tabstop=4
set shiftwidth=4

" F2 to copy word above
imap <F2> @<Esc>kyWjPA<BS>
nmap <F2> @<Esc>kyWjPA<BS>

" absolute edit line number and relative numbers elsewhere
set nu rnu

" try different colour scheme
colorscheme delek

" ctrl-backspace to delete word
inoremap  <C-W>

" Ctrl-s to save file
nmap <C-s>	:w<CR>

" Alt-Shift-O to open files in or under current directory
map <M-O> :FZF<CR>

" No conceal in markdown files
autocmd BufEnter,BufReadPre *.md set conceallevel=0

" Fix lisp code comment highlighting
autocmd BufEnter *.cl,*.lisp syn match Comment #;;.*#

" Pull in completions from included libraries
set complete+=i

" Live substitution
set inccommand=nosplit
