call plug#begin('~/.vim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Markdown Preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

  " Colorscheme
  " Plug 'EdenEast/nightfox.nvim'
  
  Plug 'morhetz/gruvbox'

  " fzf
  Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " nerdcommenter
  Plug 'preservim/nerdcommenter'

  " syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting

  " elixir
  Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
  Plug 'elixir-editors/vim-elixir'
  Plug 'mhinz/vim-mix-format'

call plug#end()

lua require("init")

" fold methods
set foldmethod=indent
set foldlevel=1
set foldclose=all

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
autocmd vimenter * ++nested colorscheme gruvbox
" set background=light

let g:gruvbox_contrast_dark = 'hard'
" colorscheme carbonfox

" Preferences
set number 
set relativenumber
set guifont=Monospace:h16

" relative number coloring 
" hi LineNrAbove guifg=DarkGray ctermfg=DarkGray
" hi LineNrBelow guifg=LightGray ctermfg=LightGray

" line number color
" hi LineNr guifg=white ctermfg=white

set expandtab ts=2 sw=2 ai
filetype plugin on
filetype plugin indent on
syntax on


""""elixir formatting setup""""

"format on save
let g:mix_format_on_save = 1


""""custom keystrokes""""
" resource to refresh vim
nnoremap <leader>sv :source $MYVIMRC<CR>

" Automatically closing braces multi-line
inoremap {<CR> {<CR>}<Esc>ko

" Automatically closing braces same line
inoremap {<Space> {<Space>}<Esc>hi

" Automatically closing brackets same line
inoremap [<Space> [<Space>]<Esc>hi

" Automatically closing brackets multi line
inoremap [<CR> [<CR>]<Esc>hi

" Automatically closing parentheses same line
inoremap (<Space> (<Space>)<Esc>hdli

" Automatically closing parentheses multi line
inoremap (<CR> (<CR>)<Esc>hdli

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" fzf options
" allow to scroll in the preview
set mouse=a

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" fzf floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

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

" set filetypes
" autocmd BufNewFile,BufRead *.ts set filetype=typescript
" autocmd BufNewFile,BufRead *.js set filetype=javascript
" autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
" autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
" autocmd BufNewFile,BufRead *.ex set filetype=elixir

" set colorcolumn
autocmd FileType javascript,typescript,javascriptreact,typescriptreact set colorcolumn=82


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8



" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" CoC configuration
let g:coc_global_extensions = [
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-snippets' ]

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

set statusline+=%F
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'        


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" " To go back to previous state use Ctrl+O

nmap <silent><leader>gd <Plug>(coc-definition)

nmap <silent><leader>gy <Plug>(coc-type-definition)

nmap <silent><leader>gi <Plug>(coc-implementation)

nmap <silent><leader>gr <Plug>(coc-references)


" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
" Licensed under CC-BY-SA
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')

if exists ("g:bclose_no_plugin_maps") &&  g:bclose_no_plugin_maps
    "do nothing
elseif exists ("g:no_plugin_maps") &&  g:no_plugin_maps
    "do nothing
else
     nnoremap <silent> <Leader>bd :Bclose<CR>
endif
