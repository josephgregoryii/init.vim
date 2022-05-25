call plug#begin('~/.vim/plugged')
  Plug 'skammer/vim-css-color'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dracula/vim', { 'name': 'dracula' }
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'pangloss/vim-javascript'
  Plug 'sbdchd/neoformat'
call plug#end()

colorscheme dracula

" Run PlugInstall on launch
" autocmd VimEnter *
"   \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
"   \|   PlugInstall | q
"   \| endif

" Preferences
set number
set expandtab ts=2 sw=2 ai
hi MatchParen cterm=none ctermbg=black ctermfg=gray

" Automatically closing braces
inoremap {<CR> {<CR>}<Esc>ko

" Automatically closing brackets
inoremap [<Space> [<Space>]<Esc>hi

" Automatically closing parentheses
inoremap (<Space> (<Space>)<Esc>hdli

" To practice vim
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 30
let g:netrw_liststyle = 3
let ghregex='^\.git$,^\.DS_Store$'
let g:netrw_list_hide=ghregex
let g:neoformat_try_node_exe = 1

au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END

" Open netrw at login
augroup ProjectDrawer
  autocmd!
  if argc() == 0
    autocmd VimEnter * :Vexplore
  elseif argc() == 1
    autocmd VimEnter * wincmd l
  endif
augroup END

" Close nvim if netrw is last buffer open
aug netrw_close
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
aug END

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" CoC configuration

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" UseK to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Vim fugative



