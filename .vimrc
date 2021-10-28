set encoding=utf-8

" 关闭vi的兼容模式(兼容模式下会让vim关闭所有的扩展，丢掉vim很多强大的功能去兼容vi)
set nocompatible

set helplang=cn

"配色风格
colorscheme gruvbox 
set background=dark

"命令历史记录次数
set history=30

" 代码高亮
"syntax on

set cursorline

" tab键缩进4个空格
set tabstop=4
"自动缩进长度4个空格
set shiftwidth=4
" 空格代替Tab
set expandtab

"继承前一行缩进方式
set autoindent

" 显示行号 相对行号
set number
set relativenumber

" 距底部5行
set scrolloff=5

" 自动换行
set wrap

" 输入命令按tab建提示
set wildmenu

" 增强自带的 ? 和 ／ 搜索功能， 并且支持更加高级的正则表达式匹配
set incsearch
" 高亮搜索内容
set hlsearch
" 查找忽略大小写
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase

" filetype vim会对文件自动检测文件类型;
" plugin 会在Vim的运行时环境目录下加载该类型相关的插件;
"   比如为了让Vim更好的支持Python编程，需要下载一些Python相关的插件，此时就必须设置plugin为on;
" indent 不同类型文件有不同的缩进方式;
"   如Python就要求使用4个空格作为缩进,c使用两个tab作为缩进;
"   那么indent就可以为不同文件类型选择合适的缩进方式了;
"   在Vim的安装目录的indent目录下看到定义了很多缩进相关的脚本
filetype plugin indent on

" 自动保存
set autowrite
" 自动读取文件(如果文本改变，自动更新）
set autoread

" 记住上次文件编辑位置
autocmd BufReadPost *
    \ if line("'\"")>0&&line("'\"")<=line("$") |
    \   exe "normal g'\"" |
    \ endif

let mapleader = '\<space>'

"============================================插件============================================================================
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jiangmiao/auto-pairs'

"中文帮助文档
Plug 'yianwillis/vimcdoc'
Plug 'morhetz/gruvbox'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' "airline 的主题5

call plug#end()

nmap <space>t <Cmd>CocCommand explorer<CR>
let g:airline_theme='dark'  " murmur配色不错

let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-vimlsp', 'coc-snippets', 'coc-marketplace', 'coc-html', 'coc-explorer', 'coc-translator', 'coc-tsserver', 'coc-prettier', 'coc-vetur', 'coc-eslint']

"=================================================coc-prettier==========================================================================
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"===========================================coc配置===========================================================================
set hidden
set updatetime=100
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-h> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
