"语法Notes:
"1.shortcuts/maps:
"   >leader is \ default,you can rewrite by: let mapleader=";"
"   >:map to see all the maps
"2.https://exvim.github.io/docs-zh/plugins/    this website contains all the vim-script
"3,if you want surfing with C++:https://github.com/Rip-Rip/clang_complete/wiki
"4.How to setting shell env/bash环境变量: let AAAA=bbbb
"5.a:表示当前函数内部的变量 g:表示全局变量
"6.sfile :fucntion stack
"  %:p:h":dir path that opened by VIM eg:vim ./
"  afile :file that opened by vim,eg:vim a.c
"  getcwd(): get the current pwd, not the opened path
"7.
"simplify(): optimize the path
"   dir="AAA/BBB/CCC/../.."
"   echo simplify(dir) --->AAA
"substitute:
"   echon " ["substitute(expand('<sfile>'), '\function \|\(\.\.\Echo\)', '', '')"]"
"   |: more cmds. eg:cmd1 | cmd


"Common head setting >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
set nocompatible               " be iMproved
filetype off                   " required!
"let mapleader=";" //just a example
"下面三个开启file检测功能，可以autocmd等一系列操作了"
filetype on
filetype plugin on
filetype indent on
"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


function PluginAirlineConfig()"{{{
    set t_Co=256
    set laststatus=2
    set lazyredraw
    "let g:airline_theme="molokai"
    let g:airline_theme='powerlineish'
    "打开会乱码
    "let g:airline_powerline_fonts=1
    "
    "打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 4

    "设置切换Buffer快捷键"
    "nnoremap <C-tab> :bn<CR>
    "nnoremap <C-s-tab> :bp<CR>
    " 关闭状态显示空白符号计数
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'

    "设置tab和tab分隔符
    let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'
    "
    "show the func name in airline
    let g:airline#extensions#tagbar#enabled = 1

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    "" old vim-powerline symbols
    "let g:airline_left_sep = '⮀'
    "let g:airline_left_alt_sep = '⮁'
    "let g:airline_right_sep = '⮂'
    "let g:airline_right_alt_sep = '⮃'
    "let g:airline_symbols.branch = '⭠'
    "let g:airline_symbols.readonly = '⭤'
    "
    "改变默认的一项显示模式
    let g:airline_section_y='%1*[%2*%{&ff}:%{&fenc}][ASCII=%03.3b][HEX=0x%02.2B]'

    let g:airline_left_sep = '▶'
    let g:airline_left_alt_sep = '>>>'
    let g:airline_right_sep = '◀'
    let g:airline_right_alt_sep = '<<<'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.readonly = ''
    let g:airline_detect_modified=1
    let g:airline_detect_paste=1

endfunction"}}}
function PluginTgasListConfig()"{{{
    ":nmap <silent> <F9> <ESC>:Tlist<RETURN>
    "tagbar setting
    :nmap <F8> :TagbarToggle<CR>
    "map <F9> :TlistToggle<CR>
    "map <F9> :silent! Tlist<CR>             "按下F3就可以呼出了
    "let Tlist_Ctags_Cmd='/usr/bin/ctags'    "因为我们放在环境变量里，所以可以直接执行
    let Tlist_Use_Right_Window=1            "让窗口显示在右边，0的话就是显示在左边
    let Tlist_Show_One_File=1               "让taglist可以同时展示多个文件的函数列表
    "let Tlist_File_Fold_Auto_Close=1        "非当前文件，函数列表折叠隐藏
    let Tlist_Exit_OnlyWindow=1             "当taglist是最后一个分割窗口时，自动推出vim
    let Tlist_Process_File_Always=1         "是否一直处理tags.1:处理;0:不处理
    "let Tlist_Inc_Winwidth=0                "不是一直实时更新tags，因为没有必要"
endfunction"}}}
function PluginleaderfConfig()"{{{
    let g:Lf_ShortcutF = '<leader>lff'
    let g:Lf_ShortcutB = '<leader>lfb'
    nmap <silent> <leader>lft <ESC>:LeaderfTag<CR>
    let g:Lf_Ctags = "/usr/local/bin/gtags"
    "let g:Lf_Ctags = "/usr/bin/ctags"
endfunction"}}}
function PluginNerdtreeConfig()"{{{
    map <F3> :NERDTreeToggle<CR>
    imap <F3> <ESC> :NERDTreeToggle<CR>
    "let NERDTreeShowHidden=1
    let NERDTreeShowLineNumbers=1
    let NERDChristmasTree=1
    let NERDTreeHighlightCursorline=1
    let NERDTreeChDirMode=2
    let NERDTreeShowBookmarks=1
    "let NERDTreeQuitOnOpen=1
    " 设置宽度
    let NERDTreeWinSize=31
    " 在终端启动vim时，共享NERDTree
    "let g:nerdtree_tabs_open_on_console_startup=1
    " 忽略某些文件的显示
    let NERDTreeIgnore=['\.o','\.cmd','\*.builtin']
    let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "✹",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "✗",
                \ "Clean"     : "✔︎",
                \ "Unknown"   : "?"
                \ }

    :autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg <CR><CR> && exec "redr!"
    "当打开vim且没有文件时自动打开NERDTree
    autocmd vimenter * if !argc() | NERDTree | endif
    "只剩 NERDTree时自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endfunction"}}}
function PluginNerdcommenterConfig()"{{{
    let g:NERDSpaceDelims=1
    "Help:
    "<leader>cc   加注释
    "<leader>cu   解开注释
    "<leader>c<space>  加上/解开注释, 智能判断
    "<leader>cy   先复制, 再注解(p可以进行黏贴)
    "
endfunction"}}}
function PluginSupertabConfig()"{{{
    "SuperTab使Tab快捷键具有更快捷的上下文提示功能。也就是一种自动补全插件,有时候跟TAB冲突　尽量不用打开
    let g:SuperTabRetainCompletionType=2
    " 0 - 不记录上次的补全方式
    " 1 - 记住上次的补全方式,直到用其他的补全命令改变它
    " 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
    "虽然supertab自动补全很好用，但是在normal情况下，是不需要补全的，实现普通缩进的功能就可以了。
    "但是被supertab占用了，tab普通情况下也不能缩进。
    "解决方法很简单:
    :unmap <c-i>
    :nmap <c-i> a空格空格空格空格
    "c-i 在vim中等同于tab  ，相当于先解除普通情况下绑定，然后绑定到输入模式加4个空格
endfunction
"}}}

"How to use vim-plug
"curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
function! Plug_manage()
    "vim-plugin 最好　其他什么vundle 就是一坨屎
    call plug#begin('~/.vim/plugged')

"Discard plugin:
    "智能补全　但是我们用C-p来操作的话　最好还是用内置自带的补全,也就是下面都不用打开
    "YouCompleteMe:太大,没有意义,别用
    "SuperTab:和TAB冲突 尽量别用
    "Plug 'SuperTab'
    "call PluginSupertabConfig();
    "">自动识别目前编码
    "Plug 's3rvac/AutoFenc'
    ">记录你每天花了多久编程，分别使用那种语言编程，分别在哪写（git）project里编过程，会把数据同步到WakaTime 路 Quantify your coding，还会每天（或每周）给你发邮件，这个要收费，免费版只保留7天的数据。
    "Plug 'wakatime/vim-wakatime'
    "">Plug 'suan/vim-instant-markdown'""{{{
    "vim-instant-markdown这是一个实时预览的插件，当你用vim打开markdown文档的时候，会自动打开一个浏览器窗口，并且可以实时预览
    "但是必须先安装新版的node.js:
    "sudo add-apt-repository ppa:chris-lea/node.js
    "sudo apt-get update
    "sudo apt-get install nodejs
    "安装完node.js之后安装instant-markdown-d
    "sudo npm -g install instant-markdown-d
"}}}

"Base Plugin:
    ">状态栏,airline 完爆 powerline
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    call PluginAirlineConfig()

    "----------------------------------------------------------------------------------------------------------------------------------------
    ">能在窗口中展示vim撤销记录。
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'mbbill/undotree'
    Plug 'flazz/vim-colorschemes'

    "----------------------------------------------------------------------------------------------------------------------------------------
    ">Gtags,cscope,tags
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'vim-scripts/gtags.vim'

    "----------------------------------------------------------------------------------------------------------------------------------------
    "Plug 'whatot/gtags-cscope.vim'     "whatot/gtags-cscope.vim千万别打开，会导致问题的,比如和F3冲突
    ">taglist tagbar
    ">>      tagbar: need ctags,就是显示一些符号变量的
    ">>      taglist:跟tagbar差不多 都是看变量函数的
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/taglist.vim'
    call PluginTgasListConfig()

    "----------------------------------------------------------------------------------------------------------------------------------------
    ">查找/search:
    ">fzf(option1) using git
    "   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    ">fzf(option2) not using git (recommand)
    "   Plug 'junegunn/fzf'
    ">leaderf(option3): <leader>f
    "   模糊查找文件，buffer，tags等，比ctrlp，unite，fzf等好用多了
    "   \lff: find file
    "   \lft: find tags
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    call PluginleaderfConfig()

    "----------------------------------------------------------------------------------------------------------------------------------------
    "窗口插件
    ">qucikfix就是我们平常用cscope搜索的窗口　或者有时候编译提示信息的窗口
    ">qucikfix是内置插件,当有错误的时候:cw才有用
    ">winmanage就是nerdtree这样的文件浏览器,这个早已经被弃用了,没有任何意义
    ">minibufexpl 就是我们打开多个文件那个小tab,不需要安装
    ">jlanzarotta/bufexplorer 就是我们用的\be那些操作
    ">NERDTREE:a very simple tree to manage the dir
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'jlanzarotta/bufexplorer'
    Plug 'scrooloose/nerdtree'

    "----------------------------------------------------------------------------------------------------------------------------------------
    ">Plug 'Xuyuanp/nerdtree-git-plugin' "感觉有点卡
    "----------------------------------------------------------------------------------------------------------------------------------------
    call PluginNerdtreeConfig()

    "----------------------------------------------------------------------------------------------------------------------------------------
    ">注释插件 注释的时候自动加个空格, 强迫症必配
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'scrooloose/nerdcommenter'
    call PluginNerdcommenterConfig()

    "----------------------------------------------------------------------------------------------------------------------------------------
    "快捷建显示和构建
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'skywind3000/quickmenu.vim'  "refer to the Initquickmenu()


    "----------------------------------------------------------------------------------------------------------------------------------------
    "括号匹配高亮/hl
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'luochen1990/rainbow'   "Plug 'kien/rainbow_parentheses.vim' this plugin is useless, it is worse than by rainbow
    let g:rainbow_active=1"

    "----------------------------------------------------------------------------------------------------------------------------------------
    ">tabular是一个帮你用像=,,这种符号来对齐一些文本的插件。当你在编写json或者有许多变量的代码 时非常有用
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'godlygeek/tabular'
    "----------------------------------------------------------------------------------------------------------------------------------------
    ">md文件语法高亮和文件类型检测
    "----------------------------------------------------------------------------------------------------------------------------------------
    Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_toc_autofit=1

	"----------------------------------------------------
	" Rust plugin
	Plug 'rust-lang/rust.vim'
	Plug 'racer-rust/vim-racer'

    "----------------------------------------------------------------------------------------------------------------------------------------
    "其他语言扩展插件
    "----------------------------------------------------------------------------------------------------------------------------------------
    ">C函数的辅助插件
    Plug 'exvim/ex-cref'
    ">vim-jsbeautify包括html,css,javascript缩进和语法高亮功能。我没用它所以没有建议
    "Plug 'maksimr/vim-jsbeautify'
    Plug 'fatih/vim-go'
    "vim-autoformat，比如c++，会自动调用诸如astyle, clang-format来对代码进行美化
    Plug 'Chiel92/vim-autoformat'
    call plug#end()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function InitPreEnv()
    "一般设置"{{{
    set report=0 "屏蔽声音
    set noswapfile
    set autowrite
    set shortmess=atI " 启动的时候不显示那个援助乌干达儿童的提示
    "set go= " 不要图形按钮，工具栏
    set showcmd " 输入的命令显示出来，看的清楚些
    set history=1000
    "set mouse=a
    "set mouse=v
    "set selection=exclusive
    "set selectmode=mouse,key
    " 在被分割的窗口间显示空白，便于阅读
    set fillchars=vert:\ ,stl:\ ,stlnc:\
    set magic
    set ignorecase"}}}
endfunction

function InitTABEnv()
    "对于已保存的文件，可以使用下面的方法进行空格和TAB的替换：
    "TAB替换为空格：
    ":set ts=4
    ":set expandtab
    ":%retab!
    "空格替换为TAB：
    ":set ts=4
    ":set noexpandtab
    ":%retab!
    set tabstop=4
    set shiftwidth=4
    " set noexpandtab
    set expandtab
    set smarttab
    "将tab替换为空格
    "nmap tt :%s/\t/ /g<CR>
endfunction

function InitVimSizeEnv()
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "vim 窗口大小
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "set lines=50"{{{
    "set columns=140
    set background=dark
    set nu  "set number""}}}
endfunction

function InitVimColorEnv()
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "颜色主题
    "终端类型       前景色          背景色          注释
    "term           -               -               黑白终端
    "cterm          ctermfg         ctermgb         彩色终端
    "gui            guifg           guibg           图形介面
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    color desert256 " 设置背景主题
    "color ron " 设置背景主题
    "color torte " 设置背景主题
    """"""""""""""""""""""""""""""""""GUI颜色配置"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    syntax on"{{{
    "set cul "高亮光标所在lines
    "set cuc "高亮当前colums
    "set cursorline " 突出显示当前行
    autocmd InsertLeave * se nocul " 取消浅色高亮当前行
    autocmd InsertEnter * se cul " 用浅色高亮当前行
    "搜索逐字符高亮
    set hlsearch
    set incsearch

    if has("gui_running")           " 如果是图形界面
        set guioptions=m        " 关闭菜单栏
        set guioptions=t        " 关闭工具栏
        "   set guioptions=L        " 启动左边的滚动条
        "   set guioptions+=r       " 启动右边的滚动条
        "   set guioptions+=b       " 启动下边的滚动条
        set clipboard+=unnamed      " 共享剪贴板
        if has("win32")
            colorscheme torte    " torte配色方案
            set guifont=Consolas:h11 " 字体和大小
        endif
    endif   "}}}
endfunction

function InitFontEnv()
    "字体编码"{{{
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "set guifont=Courier\ 8 " 设置字体
    "set guifont=Courier_New:h6:cANSI   " 设置字体
    "set guifont=Monospace\ 8  "设置字体大小
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,GB18030,cp936,big5,euc-jp,euc-kr,latin1
    set nocompatible "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
    " 显示中文帮助
    set helplang=cn
    """""""解决consle输出乱码
    "language messages zh_CN.utf-8
    "}}}
endfunction

function InitMatchComplete()
    "智能匹配，补全"
    "{{{
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set showmatch   "在输入括号时光标会短暂地跳到与之相匹配的括号处
    "现在补全功能就狂强了。需要补全的时候ctrl-x
    "ctrl-o连着按，就会跳出一个候选菜单。啊，以前不知道，还到处搜索vim补全插件。现在好了。非常齐全了。呼，赶快开始享受编程"
    set nocp
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
    "}}}
    "#中括号 大括号 小括号 自动补全"
    "{{{
    ":inoremap ( ()<ESC>i
    ":inoremap ) <c-r>=ClosePair(')')<CR>
    ":inoremap { {}<ESC>i
    ":inoremap } <c-r>=ClosePair('}')<CR>
    ":inoremap [ []<ESC>i
    ":inoremap ] <c-r>=ClosePair(']')<CR>
    ":inoremap < <><ESC>i
    ":inoremap > <c-r>=ClosePair('>')<CR>
    "function ClosePair(char)
    "    if getline('.')[col('.') - 1] == a:char
    "        return "\<Right>"
    "    else
    "        return a:char
    "    endif
    "endfunction"}}}
endfunction

function InitStatusbarEnv()
    "状态栏配置"{{{
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "[master]set ruler       " 标尺，用于显示光标位置的行号和列号，逗号分隔。每个窗口都有自己的标尺。如果窗口有状态行，标尺在那里显示。否则，它显示在屏幕的最后一行上。
    "[master]set laststatus=2 " 启动显示状态行(1),总是显示状态行(2)
    "[master]set scrolloff=3 " 光标移动到buffer的顶部和底部时保持3行距离
    " default the statusline to green when entering Vim
    "[Master]hi StatusLine ctermfg=0 ctermbg=white
    "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%] "状态行显示的内容
    "set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [%2*%Y%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]\
    "[master]set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%v,%2*%03l%1*/%3*%L(%p%%)%1*]

    "[master]function! InsertStatuslineColor(mode)
    "[master]    if a:mode == 'i'
    "[master]        hi statusline guibg=magenta term=reverse ctermbg=red gui=undercurl
    "[master]    elseif a:mode == 'r'
    "[master]        hi statusline guibg=white term=reverse ctermfg=0 ctermbg=white gui=bold,reverse
    "[master]    else
    "[master]        hi statusline guibg=blue term=reverse ctermfg=0 ctermbg=blue gui=bold,reverse
    "[master]    endif
    "[master]endfunction
    "[master]au InsertEnter * call InsertStatuslineColor(v:insertmode)
    "[master]au InsertChange * call InsertStatuslineColor(v:insertmode)
    "[master]au InsertLeave * hi statusline guibg=white term=reverse ctermfg=0 ctermbg=white gui=bold,reverse"}}}
endfunction

function InitFoldEnv()
    "折叠
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "手动Fold,选中你要折的行,在Normal模式下 输入命令 zf% 折叠匹配的符号：(){}等
    "当Fold创建后,移动光标到Fold所在行
    "输入 zo, 打开相应的Fold
    "zc, 关闭相应的Fold
    "zM, 关闭文件中所有的Fold
    "zR, 打开文件中所有的Fold
    "za, 自动打开或关闭相应的Fold，只打开一个
    "zd  删除 (delete) 在光标下的折叠。仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效。
    "zD  循环删除 (Delete) 光标下的折叠，即嵌套删除折叠。仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效。
    "zE  除去 (Eliminate) 窗口里“所有”的折叠.仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效
    "zf,创建折叠，输入移动命令，比如5j,于是折叠6行
    set foldenable " 允许折叠"{{{
    set foldmethod=manual " 手动折叠
    set foldmethod=marker " 标志折叠
    hi Folded term=standout ctermfg=4 ctermbg=red guifg=Black guibg=#e3c1a5"}}}
endfunction

function InsertHeadDef(firstLine, lastLine)"{{{
    "校验范围是否在当前Buffer的总行数之内
    if a:firstLine <1 || a:lastLine> line('$')
        echoerr 'InsertHeadDef : Range overflow !(FirstLine:'.a:firstLine.';LastLine:'.a:lastLine.';ValidRange:1~'.line('$').')'
        return "
    endif
    let sourcefilename=expand("%:t")
    let definename=substitute(sourcefilename,' ','','g')
    let definename=substitute(definename,'\.','_','g')
    let definename = toupper(definename)
    " 跳转到指定区域的第一行，开始操作
    exe 'normal '.a:firstLine.'GO'
    call setline('.', '#ifndef _'.definename."_")
    normal ==o
    call setline('.', '#define _'.definename."_")
    exe 'normal =='.(a:lastLine-a:firstLine+1).'jo'
    call setline('.', '#endif')
    " 跳转光标
    let goLn = a:firstLine+2
    exe 'normal =='.goLn.'G'
endfunction

function InsertHeadDefN()
    let firstLine = 30
    let lastLine = line('$')
    let n=1
    while n < 40
        let line = getline(n)
        if n==1
            if line =~ '^\/\*.*$'
                let n = n + 1
                continue
            else
                break
            endif
        endif
        if line =~ '^.*\*\/$'
            let firstLine = n+1
            break
        endif
        let n = n + 1
    endwhile
    call InsertHeadDef(firstLine, lastLine)
endfunction"}}}
func Settitle()
    ""自动插入文件头
    "如果文件类型为.sh文件
    if &filetype == 'sh'"{{{
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
        " elseif &filetype == 'mkd'
        " call setline(1,"<head><meta charset=\"UTF-8\"></head>")
""    else
""        call setline(1, "/*")
""        call append(line("."), "Copyright (c) 2015, Corporation. All rights reserved.")
""        call append(line(".")+1, "*Redistribution and use in source and binary forms, with or without")
""        call append(line(".")+2, "*modification, are permitted provided that the following conditions are met:")
""        call append(line(".")+3, "*")
""        call append(line(".")+4, "*1. Redistributions of source code must retain the above copyright notice,")
""        call append(line(".")+5, "*this list of conditions and the following disclaimer.")
""        call append(line(".")+6, "*")
""        call append(line(".")+7, "*2. Redistributions in binary form must reproduce the above copyright notice,")
""        call append(line(".")+8, "*this list of conditions and the following disclaimer in the documentation")
""        call append(line(".")+9, "*and/or other materials provided with the distribution.")
""        call append(line(".")+10, "*")
""        call append(line(".")+11, "*3. Neither the name of the copyright holder nor the names of its contributors")
""        call append(line(".")+12, "*may be used to endorse or promote products derived from this software without")
""        call append(line(".")+13, "*specific prior written permission.")
""        call append(line(".")+14, "*")
""        call append(line(".")+15, "*THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS'")
""        call append(line(".")+16, "*AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE")
""        call append(line(".")+17, "*IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE")
""        call append(line(".")+18, "*ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE")
""        call append(line(".")+19, "*LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR")
""        call append(line(".")+20, "*CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF")
""        call append(line(".")+21, "*SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS")
""        call append(line(".")+22, "*INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN")
""        call append(line(".")+23, "*CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)")
""        call append(line(".")+24, "*ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE")
""        call append(line(".")+25, "*POSSIBILITY OF SUCH DAMAGE.")
""        call append(line(".")+26, "*/")
""        call append(line(".")+27, "")
""        ""call setline(1, "/*************************************************************************")
""        ""call append(line("."), "    > File Name: ".expand("%"))
""        ""call append(line(".")+1, "    > Author: H.F")
""        ""call append(line(".")+3, "    > Created Time: ".strftime("%c"))
""        ""call append(line(".")+4, " ************************************************************************/")
""        ""call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        " 跳转到指定区域的第一行，开始操作
        let fline = 30
        exe 'normal '.fline.'GO'
        call setline('.', "#include<stdio.h>")
        normal ==o
        call setline('.', "#include<stdlib.h>")
    endif
    if &filetype == 'c'
        " 跳转到指定区域的第一行，开始操作
        let fline = 30
        exe 'normal '.fline.'GO'
        call setline('.', "#include<stdio.h>")
        normal ==o
        call setline('.', "#include<stdlib.h>")
    elseif &filetype == 'h'
        call InsertHeadDefN()
        "再把filetype设置回来
        set filetype=c
    endif
    "    if &filetype == 'java'
    "     call append(line(".")+6,"public class ".strpart(expand("%d"),0,strlen(expand("%"))-5))
    "     call append(line(".")+7,"")
    "    endif"}}}
endfunc

func InitNewfile()
    "因为filetype无法等于h，需要手动设置ft=h
    autocmd BufNewFile *.h exec "set filetype=h"
    "新建.c,.h,.sh,.java文件，自动插入文件头
    autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call Settitle()"
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc

function InitMapping()
    "Map"{{{
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    map! <C-O> <C-Y>,
    map <C-A> ggVG$"+y
    map <C-w> <C-w>w
    " 选中状态下 Ctrl+c 复制
    "map <C-v> "*pa
    "imap <C-v> <Esc>"*pa
    imap <C-v> <Esc>"+pa
    imap <C-a> <Esc>^
    vmap <C-c> "+y
    "去空行
    nnoremap <F2> :g/^\s*$/d<CR>

    map <F6> :call FormartSrc()<CR><CR>
    noremap <silent><F12> :map<cr>
    "}}}
endfunc

func FormartSrc()
    "代码格式优化化"{{{
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %""}}}
endfunc

function InitBufexplore()
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ""实用设置
    "some plguin:
    ""quickfix:just look up the compile err and warning
    ""buff explore:open history buff
    "\be:norma open
    "\bs:open buff horizal
    "\bv:open buff vertical
    "\b
    ""minibufexpl:mini window can exploer the buff that opened
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>"{{{
    if has("autocmd")
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \ exe "normal g`\"" |
                    \ endif
    endif
    " 设置当文件被改动时自动载入
    set autoread
    "quit the win:ALT+F3
    nmap<M-F3> :q!<CR>"}}}
endfunc

function! Echo(msg,...)"{{{
    "Title ErrorMsg WarningMsg
    echohl Title 
    ""ErrorMsg represent the red color
    ""if the funciton name is s:echo,this is the droid you're looking for
    ""echo substitute(expand('<sfile>'), '.*\(\.\.\|\s\)', '', '')
    "" compare with this (not what you want, just for reference)
    "echo expand('<sfile>')
    let index = 1
    let msg_all="[-vimrc-]".a:msg
    while index <= a:0
        let msg_all=msg_all . a:{index} 
        let index = index + 1
    endwhile
    "echo printf("%s",msg_all)
    echo printf("%-100.100s",msg_all)
    let stack_msg=substitute(expand('<sfile>'), '\(\.\.\Echo\)', '', '')
    echon "["substitute(expand(stack_msg), '\(\function \)', '', '')"]"
    echo ""
    echohl None
endfunction"}}}
function LoadingCscopeTags(tagsdir)"{{{
"if has('cscope')
    call SetupCscopeEnv()
    if filereadable(a:tagsdir . 'cscope.out')
        let cscope_file=findfile('cscope.out', '.;')
        let cscope_path=matchstr('cscope.out', a:tagsdir)
        if  !filereadable(cscope_file)
            call Echo("NO cscope to be found")
            return 0
        endif

        if executable('cscope')
            call Echo("cscope is available")
            call Echo("Add cscope:" . cscope_path . cscope_file)
            exe "cs add" cscope_file cscope_path
        elseif
            call Echo("cscope is disable")
            return 0
        endif

    endif
    if filereadable(a:tagsdir . 'tags')
        if executable('ctags')
            call Echo("ctags is available")
            execute 'set tags =' . a:tagsdir . 'tags'
            call Echo("Add ctags:" . a:tagsdir . 'tags')
        elseif
            call Echo("ctags is disable")
            return 0
        endif
    endif
    return 1
endfunction"}}}
function! SetupCscopeEnv() "{{{
    " Disable gtags temporary
    "csto：命令的查找次序，默认为0，0为从cscope开始，1为从ctags开始,cscopetagorder==csto
    set csto=0
    "是否用cscope代替ctags，在需要使用tag文件的时候，比如:tag命令和<C-]>命令 , cscopetag == cst
    set cst
    "是否告之数据库加载结果
    set nocsverb
    ""cspc decide the length of path,cscopepathcomp==cspc
    set cspc=0
    "cscopequickfix：设置quickfix窗口里显示的选项，+代表添加到quickfix窗口，-代表清楚上次选项，0代表不添加
    set cscopequickfix=s0,c0,d0,i0,t0,e0
    "cscopeprg==csprg
    set csprg=/usr/bin/cscope
endfunction "}}}
function! CleanupCscopeEnv() "{{{
endfunction "}}}
function! FindFiles(pat, ...)"{{{
     let path = ''
     for str in a:000
         let path .= str . ','
     endfor

     if path == ''
         let path = &path
     endif

     call Echo('finding...')
     redraw
     call append(line('$'), split(globpath(path, a:pat), '\n'))
     call Echo('finding...done!')
     redraw
endfunc"}}}
function! UpdatingGtags(f)"{{{
     let dir = fnamemodify(a:f, ':p:h')
     "坚决不用gtags -u这个命令有很大的弊端　　会产生很多小的进程在后台　所以基本上这个命令也被gtags官方都否认了
     "exe 'silent !cd ' . dir . ' && gtags -i '
     "exe 'silent !cd ' . dir . ' && gtags -i &> /dev/null &'
     exe 'silent !cd ' . dir . ' && gtags --single-update 'a:f' &> /dev/null &'
     call Echo("GTAGS Updateing:" . a:f)
 endfunction"}}}
function! SetupUpdatingGtags()"{{{
    "command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
    au BufWritePost *.[ch] call UpdatingGtags(expand('<afile>'))
endfunc"}}}
function! LoadingGtags(tagsdir)"{{{
    if filereadable(a:tagsdir . 'GTAGS')
        let tags_file="GTAGS"
        let tags_path=a:tagsdir
        if executable('gtags-cscope')
            call SetupGtagsEnv(a:tagsdir)
            call SetupGtagsMappings()
            call SetupUpdatingGtags()
            call Echo("Loading GTAGS:". a:tagsdir . 'GTAGS')
            exe "cs add " . a:tagsdir . 'GTAGS'
        elseif
            call Echo("Please Install gtags-cscope")
            return 0
        endif
        return 1
    endif
    call Echo("Not found GTAGS in ",a:tagsdir)
endfunction"}}}
function! SetupGtagsEnv(tagsdir) "{{{
    "" Treat 'h' file as c++ type for gtags
    "let $GTAGSFORCECPP = 1 
    "let project_path=getcwd()
    "get the father dir,remove the .tags_dir
    let project_path=substitute(expand(a:tagsdir), '\(\.tags_dir\/\)', '', '')
    " Set the root of source tree for gtags, this config can locate your file path
    let $GTAGSROOT = project_path
    " Set the directory on which tag files exists,this config will help you to add the tags
    "let $GTAGSDBPATH = expand("%:p:h") . '/.tags_dir'
    let $GTAGSDBPATH = a:tagsdir
    call Echo("GTAGSROOT=",$GTAGSROOT)
    call Echo("GTAGSDBPATH=",$GTAGSDBPATH)

    set csto=0
    set cst
    set cspc=0
    "set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-
    set cscopequickfix=s0,c0,d0,i0,t0,e0
    set csprg=gtags-cscope "csprg==cscopeprg

    " To use the default key/mouse mapping:
    "	let g:GtagsCscope_Auto_Map = 1
    " To ignore letter case when searching:
    "	let g:GtagsCscope_Ignore_Case = 1
    " To use absolute path name:
    "       let g:GtagsCscope_Absolute_Path = 1
    " To deterring interruption:
    "	let g:GtagsCscope_Keep_Alive = 1
    " If you hope auto loading:
    "	let GtagsCscope_Auto_Load = 1
    " To use 'vim -t ', ':tag' and '<C-]>'
    "	set cscopetag
    let g:GtagsCscope_Auto_Load = 1
    let g:GtagsCscope_Auto_Map = 1
    let g:GtagsCscope_Absolute_Path = 1
endfunction "}}}
function! CleanupGtagsEnv() "{{{
    " Treat 'h' file as c++ type for gtags
    set cscopeprg&
    let $GTAGSFORCECPP=""
    let $GTAGSROOT=""
    let $GTAGSDBPATH=""
endfunction "}}}
function! FindingTagsDir()"{{{
    let maxdepth = 4
    "call Echo("VimOPenFile",expand('<afile>'))
    let VimOpenPath=expand("%:p:h")
    call Echo("OpenPath=" . VimOpenPath)
    let dir =getcwd()
    let i = 0
    while i < maxdepth
        let dir=simplify(dir)
        let tags_dir_path=dir . '/.tags_dir/'
        if filereadable(dir . '/GTAGS')
            call Echo("Finding GTAGS: ".dir)
            if executable('gtags-cscope')
                call LoadingGtags(dir . '/')
                break
            elseif executable('cscope')
                call LoadingCscopeTags(dir)
                break
            endif
        endif

        if isdirectory(tags_dir_path)
            call Echo("Finding .tags_dir:". tags_dir_path)
            if executable('gtags-cscope')
                call LoadingGtags(tags_dir_path)
                break
            elseif executable('cscope')
                call LoadingCscopeTags(tags_dir_path)
                break
            endif
        endif

        let dir = dir . '/..'
        let i = i + 1
        if i == maxdepth
            call Echo("Not found .tags_dir")
        endif
    endwhile
endfunction"}}}
function! PluginGtagsConfig()"{{{
    call FindingTagsDir()
endfunction"}}}
function SetupGtagsMappings()"{{{
    nmap <silent> <leader>j <ESC>:cstag <c-r><c-w><CR>
    nmap <silent> <leader>g <ESC>:lcs f c <c-r><c-w><cr>:lw<cr>
    nmap <silent> <leader>s <ESC>:lcs f s <c-r><c-w><cr>:lw<cr>
    "command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
endfunc"}}}

"Show the shortcuts info in the quickmenu
function! Initquickmenu()"{{{
    call quickmenu#current(0)
    call quickmenu#reset()
    " choose a favorite key to show/hide quickmenu
    noremap <silent><F12> :call g:quickmenu#toggle(0)<cr>
    " enable cursorline (L) and cmdline help (H)
    let g:quickmenu_options = "HL"

    " section 1, text starting with "#" represents a section (see the screen capture below)
    call g:quickmenu#append('# Bufexplore', '')

    call g:quickmenu#append('item 1.1', 'echo "1.1 is selected"', 'select item 1.1')
    call g:quickmenu#append('item 1.2', 'echo "1.2 is selected"', 'select item 1.2')
    call g:quickmenu#append('item 1.3', 'echo "1.3 is selected"', 'select item 1.3')

    " section 2
    call g:quickmenu#append('# Misc', '')

    call g:quickmenu#append('item 2.1', 'echo "2.1 is selected"', 'select item 2.1')
    call g:quickmenu#append('item 2.2', 'echo "2.2 is selected"', 'select item 2.2')
    call g:quickmenu#append('item 2.3', 'echo "2.3 is selected"', 'select item 2.3')
    call g:quickmenu#append('item 2.4', 'echo "2.4 is selected"', 'select item 2.4')
    "call quickmenu#append('Function list', 'call Toggle_Tagbar()', 'show/hide tagbar')
endfunction
"}}}

function InitPostEnv()
    "some delay config"{{{
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "inoremap <expr> <C-r>* repeat('*', strdisplaywidth(getline(line('.')-1))-strdisplaywidth(getline('.')))
    "行尾空格高亮,it must be settle on the end of .vimrc
    "highlight WhitespaceEOL ctermbg=red  guibg=red
    "match WhitespaceEOL /\s\+$/

    "显示行尾的tab和多余空格
    set list
    "set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
    set lcs=trail:·,tab:•\ 
    ""if we want to highlight the tab and trail , you must take a script under .vimr/syntax/XXX.vim
    hi Trail ctermbg=red  guibg=red
    match Trail /\s\+$/
    "hi TAB ctermbg=red  guibg=red
    "syn match Trail /\v\*\=/
    "syn match TAB /\t/"}}}
    "autocmd VimEnter * echohl ErrorMsg | echomsg "Usually Cmds: cs show" | echohl None
   "autocmd VimEnter * silent cs show <ESC><CR><ESC>
   call InitMapping()
   "call Initquickmenu()
endfunction

call Plug_manage()
call InitPreEnv()
call InitTABEnv()
call InitVimColorEnv()
call InitVimSizeEnv()
call InitBufexplore()
call InitMatchComplete()
call InitFoldEnv()
call InitNewfile()
"call InitFontEnv()
call PluginGtagsConfig()
call InitPostEnv()
