call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" plugin for syntax
Plug 'scrooloose/syntastic'

"plugin for file explorer
Plug 'preservim/nerdtree'

"plugin for color scheme c++
Plug 'octol/vim-cpp-enhanced-highlight'

"plugin cmake
Plug 'vhdirk/vim-cmake'

"plugin colorscheme
Plug 'dracula/vim', { 'name': 'dracula' }

" Initialize plugin system
call plug#end()


"set plugins
set rtp+=~/.vim/bundle/YouCompleteMe/

"map the leader
let mapleader=","

"mapping buttons
map <C-L> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.git,build,bin .<CR><CR>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
function! OpenOther()
    if expand("%:e") == "cpp"
        exe "split" fnameescape(expand("%:p:r:s?src?include?").".h")
    elseif expand("%:e") == "h"
        exe "split" fnameescape(expand("%:p:r:s?include?src?").".cpp")
    endif
endfunction
nmap <leader>j :call OpenOther()<CR>
set makeprg=make\ -C\ build\ -j3
map <F2> :!ls<CR>:e
nnoremap <F3> :@:<cr>
nnoremap <F4> :make!<bar>copen<cr>
nnoremap <F5> :FZF<cr>
nnoremap <silent> <expr> <F6> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <F8> :source ~/.vimrc<cr>
nnoremap <F12> :call <SID>helpfile()<cr>
""tab navigation
nnoremap <C-Left> :tabprevious<CR>                                                                            
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>                                                                            
nnoremap <C-k> :tabnext<CR>
""save with double Esc
map <Esc><Esc> :w<CR>
""comment lines
:vnoremap <C-c><C-c> :norm i//<Cr>
:vnoremap <C-u><C-u> :s/\/\///g<Cr>:noh<Cr>

" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
map <C-v> pi
imap <C-v> <Esc>pi
imap <C-z> <Esc>ui



"set random stuff
syntax on
"colorscheme dracula
set exrc
set secure
set tabstop=2
set softtabstop=2
set shiftwidth=4
set noexpandtab
set colorcolumn=120
set splitright
set splitbelow
set number
set mouse=a
set ttymouse=xterm2
set hlsearch
set nocp
set confirm
set switchbuf=useopen,usetab,newtab
filetype plugin on
highlight ColorColumn ctermbg=darkgray

let &path.="/usr/local/include/AL,/usr/include/AL,"
set includeexpr=substitute(v:fname,'\\.','/','g')

"set clang
let g:clang_library_path="/usr/lib/llvm-8/lib"

"set tags
set tags=tags;,.tags;,../tags;

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
"save the file while you are changing it
autocmd TextChanged,TextChangedI <buffer> silent write

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

"open/close the command help
function! s:helpfile()
	let b = bufwinnr("~/.vim/help_commands.txt")
	if(b > 0)
		echo "message already opened"
		exe b.'wincmd w'
		:bw
		let bufnum=len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
		if (g:NERDTree.IsOpen() > 0 && bufnum == 1)
			:q
		endif
	else
		echo "not opened"
		:vsp|view ~/.vim/help_commands.txt
	endif
endfunction

"delete swapfiles :tabdo Deleteswaps
function! Deleteswaps()
    write
    let l:output = ''
    redir => l:output 
    silent exec ':sw' 
    redir END 
    let l:current_swap_file = substitute(l:output, '\n', '', '')
    let l:base = substitute(l:current_swap_file, '\v\.\w+$', '', '')
    let l:swap_files = split(glob(l:base.'\.s*'))
    " delete all except the current swap file
    for l:swap_file in l:swap_files
        if !empty(glob(l:swap_file)) && l:swap_file != l:current_swap_file 
            call delete(l:swap_file)
            echo "swap file removed: ".l:swap_file
        endif
    endfor
    " Reset swap file extension to `.swp`.
    set swf! | set swf!
    echo "Reset swap file extension for file: ".expand('%')
endfunction
command! Deleteswaps :call Deleteswaps()

" Drop Syntastic settings at the end of the config file "
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'

"color scheme
let c_no_curly_error=1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1


"tips
":tabe % open the current buffer in a new tab
":vsplit split the current buf vertically
":split split the current tab horizontally
":tabnew filename open the file in a new tab
"/name find the name of the variable in a file
"/+Ctrl+f show the search history
":FZF search quickly for a file (you can push F5 as well)
"in visual mode if you do gd or gD you search for a variable under the cursor
"t open file in a new tab
"i open file in a horizontal split window
"s open file in a vertical split window

