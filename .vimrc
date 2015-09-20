" use spaces in place of tabs
set expandtab

" number of spaces for a tab
set tabstop=4

set shiftwidth=4
set softtabstop=4

" always indent/outdent to the nearest tabstop
set shiftround

" show (partial) command in status line.
set showcmd
set statusline=%F%(\ [%M%R%H]%)%=%(\|line\ %-4.4l\|col\ %-3.3c\%)
set laststatus=2 set autoindent
set smartindent

" show matching brackets.
set showmatch

" highlight trailing spaces
au BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\s\+$', -1)

" highlight tabs between spaces
au BufNewFile,BufRead * let b:mtabbeforesp=matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
au BufNewFile,BufRead * let b:mtabaftersp=matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)

" не создавать резервных копий файлов
set nobackup
set noswapfile

" unicode
set encoding=utf-8

" colors
"colorscheme desert256
colorscheme desert

" end of line
set ff=unix

" включить показ номеров строк
set number

" <F7> EOL format (dos <CR><NL>,unix <NL>,mac <CR>)
set  wildmenu
set  wcm=<Tab>
menu EOL.unix :set fileformat=unix<CR>
menu EOL.dos  :set fileformat=dos<CR>
menu EOL.mac  :set fileformat=mac<CR>
map  <F7> :emenu EOL.<Tab>

" <F8> change encoding
set  wildmenu
set  wcm=<Tab>
menu Enc.cp1251     :e ++enc=cp1251<CR>
menu Enc.koi8-r     :e ++enc=koi8-r<CR>
menu Enc.cp866      :e ++enc=ibm866<CR>
menu Enc.utf-8      :e ++enc=utf-8<CR>
menu Enc.ucs-2le    :e ++enc=ucs-2le<CR>
map  <F8> :emenu Enc.<Tab>

" <Shift+F8> convert file encoding
set  wildmenu
set  wcm=<Tab>
menu FEnc.cp1251    :set fenc=cp1251<CR>
menu FEnc.koi8-r    :set fenc=koi8-r<CR>
menu FEnc.cp866     :set fenc=ibm866<CR>
menu FEnc.utf-8     :set fenc=utf-8<CR>
menu FEnc.ucs-2le   :set fenc=ucs-2le<CR>
map  <S-F8> :emenu FEnc.<Tab>

" собственные функции для назначения имен заголовкам табов -->
    function! MyTabLine()
        let tabline = ''

        " формируем tabline для каждой вкладки -->
            for i in range(tabpagenr('$'))
                " подсвечиваем заголовок выбранной в данный момент вкладки.
                if i + 1 == tabpagenr()
                    let tabline .= '%#TabLineSel#'
                else
                    let tabline .= '%#TabLine#'
                endif

                " устанавливаем номер вкладки
                let tabline .= '%' . (i + 1) . 'T'

                " получаем имя вкладки
                let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
            endfor
        " формируем tabline для каждой вкладки <--

        " заполняем лишнее пространство
        let tabline .= '%#TabLineFill#%T'

        " выровненная по правому краю кнопка закрытия вкладки
        if tabpagenr('$') > 1
            let tabline .= '%=%#TabLine#%999XX'
        endif

        return tabline
    endfunction

    function! MyTabLabel(n)
        let label = ''
        let buflist = tabpagebuflist(a:n)

        " имя файла и номер вкладки -->
            let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

            if label == ''
                let label = '[No Name]'
            endif

            let label .= ' (' . a:n . ')'
        " имя файла и номер вкладки <--

        " определяем, есть ли во вкладке хотя бы один
        " модифицированный буфер.
        " -->
            for i in range(len(buflist))
                if getbufvar(buflist[i], "&modified")
                    let label = '[+] ' . label
                    break
                endif
            endfor
        " <--

        return label
    endfunction

    function! MyGuiTabLabel()
        return '%{MyTabLabel(' . tabpagenr() . ')}'
    endfunction

    set tabline=%!MyTabLine()
    set guitablabel=%!MyGuiTabLabel()
" задаем собственные функции для назначения имен заголовкам табов <--

