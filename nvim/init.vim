"" Settings {{{
filetype plugin indent on
syntax enable
let mapleader = " "
set timeoutlen=550 ttimeoutlen=0 updatetime=250
set hidden
set noswapfile
set title
set mouse=a
set scrolloff=999
set number
set expandtab tabstop=2 shiftwidth=2
set splitbelow
set splitright
set cursorline
set ignorecase
set smartindent
set virtualedit=block
set lazyredraw
set whichwrap+=<,>,h,l,[,]
set autowrite
set autoread
set autowriteall
set gdefault
set inccommand=split
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
set synmaxcol=1500
set nobackup
set nowritebackup
set shortmess+=c
set cmdheight=2
set signcolumn=number
"" }}}

" Remappings and Commands {{{
nnoremap <silent> <esc> :noh<cr><esc>
nnoremap <space>s :w<CR>
nnoremap gp `[v`]
nnoremap Q @q
nnoremap gj J
nnoremap <c-g> :let @+ = expand("%:p") . ":" . line(".") \| echo 'copied ' . @+ . ' to the clipboard.'<CR>
nmap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nmap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
nnoremap J }
nnoremap K {
vnoremap J }
vnoremap K {
nnoremap j gj
nnoremap k gk
vnoremap < <gv
vnoremap > >gv

com! Wq :wq
com! WQ :wq
com! Vimrc :edit $MYVIMRC
com! Messages :enew | put =execute('messages')
"" }}}

"" Remember {{{

"" visual select next search match: gn

"" }}}

call plug#begin()

"" Wiki {{{
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
"" }}}

"" Monokai Theme & Statusline {{{
Plug 'crusoexia/vim-monokai'
Plug 'rbong/vim-crystalline'
Plug 'gcavallanti/vim-noscrollbar'
"" }}}

"" Autocomplete {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Play nice with endwise.vim (enter to select snippet conflicts)
let g:endwise_no_mappings = v:true
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <leader>k to show documentation in preview window.
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup coc
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

command! -nargs=0 Format :call CocAction('format')

" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" }}}

"" Clipboard & Yanking {{{
set clipboard=unnamed,unnamedplus
Plug 'svermeulen/vim-yoink'
let g:yoinkSyncNumberedRegisters = 1
let g:yoinkIncludeDeleteOperations = 1
nmap <c-p> <plug>(YoinkPostPasteSwapBack)
nmap <c-n> <plug>(YoinkPostPasteSwapForward)
nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
nmap Y y$
"" }}}

"" Undo {{{
Plug 'mbbill/undotree'
nmap U <C-r>
let g:undotree_WindowLayout = 4
let g:undotree_SplitWidth = 25
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HelpLine = 0
let g:undotree_HighlightChangedText = 0
let g:undotree_ShortIndicators = 1
set undofile
set undodir=~/.config/nvim/undo
set undolevels=10000
set undoreload=10000
"" }}}

"" Utilities and stuff from tpope {{{
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-peekaboo'
Plug 'farmergreg/vim-lastplace'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'airblade/vim-rooter'
Plug 'voldikss/vim-browser-search'
nmap <silent> <leader>go <Plug>SearchNormal
vmap <silent> <leader>go <Plug>SearchVisual

Plug 'svermeulen/vim-NotableFt'
" Plug '~/.config/nvim/vim-play-piano'
"" }}}

"" Surround and Align {{{
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

"" Commenting and Auto close pairs {{{
Plug 'tomtom/tcomment_vim'
" Plug 'tyru/caw.vim'
" Plug 'suy/vim-context-commentstring'
" Plug 'tpope/vim-commentary'

Plug 'tmsvg/pear-tree'
let g:pear_tree_repeatable_expand=0
let g:pear_tree_map_special_keys=0
"" }}}

"" File Managing {{{
let g:ranger_replace_netrw = 1
source ~/.config/nvim/ranger.vim
nmap <silent> - :Ranger<cr>

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
" Plug 'lambdalisue/fern-hijack.vim'
" nnoremap <silent> - :Fern . -reveal=%<cr>
nnoremap <silent> \ :Fern . -stay -toggle -reveal=% -drawer<cr>

function! s:init_fern() abort
  setlocal listchars= nonumber norelativenumber
  setlocal signcolumn=no
endfunction

let g:fern#renderer#default#leaf_symbol = '   '
let g:fern#renderer#default#collapsed_symbol = '>- '
let g:fern#renderer#default#expanded_symbol = '>+ '

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

function! s:OpenDrawer() abort
  if &modifiable && filereadable(expand('%'))
    execute printf('FernDo -stay FernReveal %s', fnameescape(expand('%:p')))
  endif
endfunction

autocmd BufEnter * call s:OpenDrawer()
" }}}

"" Substitution & Abreviation {{{
Plug 'lambdalisue/reword.vim'
Plug 'svermeulen/vim-subversive'
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)
"" }}}

"" Git {{{
Plug 'airblade/vim-gitgutter'
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_sign_added = '▷'
let g:gitgutter_sign_modified = '△'
let g:gitgutter_sign_removed = '◁'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed   = '◁△'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
au FileType gitcommit execute "normal! O" | startinsert
nnoremap <silent> <space>gd :Gdiff<CR>
nnoremap <silent> <space>gb :Gblame<CR>
nnoremap <silent> <space>gL :Glog --author=sevensidedmarble <CR>
nnoremap <silent> <space>gl :Glog<CR>
nnoremap <silent> <space>gg :Gstatus<CR>
nnoremap <space>GP :Git push origin HEAD<cr>

augroup FugitiveMappings
  autocmd!
  autocmd FileType fugitive nmap <buffer> <Tab> =
augroup END
"" }}}

"" Buffers {{{
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
nnoremap <silent> <c-x><c-k> :Sayonara!<CR>
nnoremap <silent> <c-h> :bp<CR>
nnoremap <silent> <c-l> :bn<CR>
nmap <silent> <c-x><c-s> :w<CR>
nmap <silent> <c-x><c-b> :Buffers<CR>
nmap <silent> <c-x><b> :Buffers<CR>
"" }}}

"" Languages {{{
Plug 'sheerun/vim-polyglot'
Plug 'vim-test/vim-test'

" Ruby on Rails
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-rake'
" Plug 'ngmy/vim-rubocop', { 'on': 'RuboCop' }
"" }}}

"" FZF {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

function! s:GetVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let offset = &selection ==# 'exclusive' ? 2 : 1
  let lines[-1] = lines[-1][:column_end - offset]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

let s:rg_common = 'rg --column --line-number --no-heading --color=always ' .
      \ '--smart-case '

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   s:rg_common . '--fixed-strings ' . shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview(
      \     { 'options': '--delimiter : --nth 4..' }, 'right:50%'),
      \   <bang>0)

command! -bang -nargs=* -complete=dir Rgd
      \ call fzf#vim#grep(
      \   s:rg_common . '--fixed-strings ' . shellescape(''),
      \   1,
      \   fzf#vim#with_preview(
      \     { 'dir': fnamemodify(expand(<q-args>), ':p:h'),
      \       'options': '--delimiter : --nth 4..' },
      \     'right:50%'),
      \   <bang>0)

command! -bang -nargs=* Rgr
      \ call fzf#vim#grep(
      \   s:rg_common . shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview({ 'options': '--delimiter : --nth 4..' },
      \     'right:50%'),
      \   <bang>0)

autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <Space>/ :Rg!<CR>
vnoremap <Space>/ :<C-U>Rg!<Space><C-R>=<SID>GetVisualSelection()<CR><CR>

nnoremap <silent> <Space>hh :Helptags!<CR>
nnoremap <silent> <Space>fr :History!<CR>
nnoremap <silent> <Space><Space> :Files!<CR>
"" }}}

"" Terminals {{{
au TermOpen * setlocal listchars= nonumber norelativenumber
au TermOpen * startinsert
au BufEnter,BufWinEnter,WinEnter term://* startinsert
au BufLeave term://* stopinsert
tnoremap <Esc> <C-\><C-n>
autocmd! FileType fzf tnoremap <buffer><silent><Esc> <C-\><C-n>:bd!<cr>
tnoremap <silent> <c-h> <C-\><C-n>:bp<CR>
tnoremap <silent> <c-l> <C-\><C-n>:bn<CR>
"" }}}

"" ALE {{{
" Plug 'dense-analysis/ale'
" let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
" let g:ale_linters = {'svelte': ['stylelint', 'eslint']}
" let g:ale_fixers = {
"   \ 'svelte': ['eslint', 'prettier', 'prettier_standard'],
"   \ 'javascript': ['prettier']
" \ }
" function! AleStatus() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? 'it just works ¯\_(ツ)_/¯' : printf(
"         \ 'Warn:%d Error:%d',
"         \ l:all_non_errors,
"         \ l:all_errors
"         \)
" endfunction
"" }}}

call plug#end()

"" Colors {{{
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=100 }
augroup END

augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight diffRemoved cterm=NONE ctermbg=239 gui=NONE guifg=#64645e
                      " \ | highlight SignColumn guibg=bg
                      " \ | highlight LineNr guibg=#272822
                      " \ | highlight NonText guifg=bg
augroup END
colorscheme monokai
set termguicolors
lua require'colorizer'.setup()

com! WhichHi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"" }}}

"" StatusLine and TabLine {{{
let s:second = 1
let s:minute = 60 * s:second
let s:hour = 60 * s:minute
let s:day = 24 * s:hour
let s:week = 7 * s:day
let s:month = 30 * s:day
let s:year = 365 * s:day

function! s:get_undo_time(undo_dict) abort
  let l:idx = a:undo_dict.seq_cur
  for l:entry in a:undo_dict.entries
    if l:entry.seq == l:idx
      return l:entry.time
    endif
  endfor
  return localtime()
endfunction

function! StatusTimeLine() abort
  let l:undo_dict = undotree()
  if l:undo_dict.seq_cur == l:undo_dict.seq_last | return 'Present' | endif

  let l:delta_t = localtime() - s:get_undo_time(l:undo_dict)
  if l:delta_t > s:year
    return 'More than a year ago'
  elseif l:delta_t > s:month 
    return 'More than a month ago'
  elseif l:delta_t > s:week
    let l:n_weeks = l:delta_t / s:week
    let l:plural = l:n_weeks > 1
    return 'More than ' . l:n_weeks . ' week' . (l:plural ? 's' : '') . ' ago'
  elseif l:delta_t > s:day
    let l:n_days = l:delta_t / s:day
    let l:plural = l:n_days > 1
    return l:n_days . ' day' . (l:plural ? 's' : '') . ' ago'
  elseif l:delta_t > s:hour
    let l:n_hours = l:delta_t / s:hour
    let l:plural = l:n_hours > 1
    return l:n_hours . ' hour' . (l:plural ? 's' : '') . ' ago'
  elseif l:delta_t > s:minute
    let l:n_minutes = l:delta_t / s:minute
    let l:plural = l:n_minutes > 1
    return l:n_minutes . ' minute' . (l:plural ? 's' : '') . ' ago'
  elseif l:delta_t > s:second
    return 'Seconds ago'
  else
    return 'ERROR: Delta T: ' . l:delta_t
  endif
endfunction

function! TabLine()
  let l:s = ''
  let l:vimlabel = has('nvim') ?  'NVIM IS BEST VIM ' : 'REGULAR VIM '

  if &filetype ==# 'fzf'
    let l:s = '%#NonText#'
  else
    let l:s .= crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . '%{StatusTimeLine()} '

  endif

  if &filetype ==# 'ranger'
    let l:s = '%#NonText#'
  endif

  return l:s
endfunction

let g:crystalline_tabline_fn = 'TabLine'
set showtabline=2

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

function! StatusLine(current)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
        \ . crystalline#left_sep('', 'Fill') . (a:current ? ' %{&ft} col:%3c %{noscrollbar#statusline()} ' : '')
endfunction

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current && fugitive#head() != ''
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}[%{GitStatus()}]'
  elseif a:current
    let l:s .= crystalline#right_sep('', 'Fill')
  endif

  let l:s .= "%=  %{coc#status()}%{get(b:,'coc_current_function','')} "
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&ft} %{&spell?"(SPELL) ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %l:%2c %{noscrollbar#statusline()}  '
  else
    let l:s .= ' '
  endif

  if &buftype ==# "terminal"
    let l:s = '%#NonText#'
  endif

  return l:s
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'gruvbox'
hi! CrystallineFill guibg=#272822
set laststatus=2
"" }}}

"" Highlight trailing whitespace {{{
function! s:MatchExtraWhitespace(enabled)
match ExtraWhitespace /\s\+$/
endfunction
highlight link ExtraWhitespace Error
augroup ExtraWhitespace
  autocmd!
  autocmd BufWinEnter * call s:MatchExtraWhitespace(1)
  autocmd FileType * call s:MatchExtraWhitespace(1)
  autocmd InsertEnter * call s:MatchExtraWhitespace(0)
  autocmd InsertLeave * call s:MatchExtraWhitespace(1)
  autocmd BufWinLeave * call clearmatches()
augroup END
"" }}}

"" Specific FileType stuff {{{
augroup TextFormatting
  autocmd!
  autocmd FileType vim
        \ setlocal fdm=marker foldlevel=0
augroup END

" Open help windows vertically
autocmd FileType help wincmd L
"" }}}

"" Folding {{{
hi Folded guibg=#272822 guifg=#ffd866
set foldlevel=99
set foldnestmax=4
set fdm=syntax
function! MyFoldText()
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 7
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart(' ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)

  return line . ' ⸬' . repeat(" ",fillcharcount) . foldedlinecount . ' ⸬ '
endfunction

set foldtext=MyFoldText()
"" }}}
