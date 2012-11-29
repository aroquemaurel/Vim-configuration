" Global settings
set nocompatible
syntax on
set shiftwidth=4
set tabstop=4
set softtabstop=4
set scrolloff=3     " keep 3 lines when scrolling
set ls=2            " allways show status line
set showcmd         " display incomplete commands
set backspace=2
set wm=10
set report=0

"afficher une liste lors de complétion de commande
set wildmode=list:full

set background=dark

set incsearch       " do incremental searching
set hlsearch        " highlight searches
set ignorecase      " ignore case when searching 
set infercase

set mouse=a
set number
set ruler           " show the cursor position all the time

set visualbell t_vb=    " turn off error beep/flash
set title           " show title in console title bar
set ttyfast         " smoother changes
set nostartofline   " don't jump to first character when paging
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
"set novisualbell    " turn off visual bell

set autoindent     " always set autoindenting on
set smartindent        " smart indent
set smarttab
set cindent            " cindent

"sauvegardes
if filewritable(expand("~/.vim/backup")) == 2
	set backupdir=$HOME/.vim/backup
else
	if has("unix") || has("win32unix")
		call system("mkdir -p $HOME/.vim/backup")
		set backupdir=$HOME/.vim/backup
	endif
endif

noremap <C-o> :set spell spelllang=fr <cr>
noremap <F4> :set spell spelllang=en <cr>
noremap <F8> :set t_Co=8 <cr> :colorscheme default<cr>
noremap <F6> :set nospell <cr>
"set spell spelllang=fr
"set spell spelllang=en
set cursorline
highlight CursorLine ctermbg=darkgray

"couleur numéros de ligne
highlight LineNr term=bold ctermfg=gray guifg=darkgray

"highlight OverLength ctermfg=darkgray guibg=#592929
"match OverLength /\%81v.*/
:au BufWinEnter * let w:m1=matchadd('Error', '\%<102v.\%>100v', -1)


" Special configuration for development
":filetype on
":autocmd FileType c,cpp,cxx,h set cindent|set cine=:0|set tabstop=10|set softtabstop=2|set expandtab
":autocmd FileType make setlocal noexpandtab
" Special highlighting for Doxygen
":let g:load_doxygen_syntax=1
" Show when a line exceeds 80 chars


"  Highlight Tabs and Spaces
"highlight Tab ctermbg=darkgray guibg=darkgray

"highlight Space ctermbg=darkblue guibg=darkblue

"set list listchars=tab:»·,trail:·
set tags+=~/.vim/tags/stl
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

" build tags of your own project with CTRL+F12
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

nnoremap <silent> <F9> :NERDTree <cr>
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview


autocmd BufRead *.algo set ft=algo "on active la coloration pour les fichiers .algo

:let filetype_i = "asm68k"

set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%


" shebang automatique lors de l'ouverture nouveau
" d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
:autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
:autocmd BufNewFile *.py 0put=\"#!/usr/bin/env python\"|1put=\"# -*- coding: UTF8 -*-\<nl>\<nl>\"|$


:autocmd BufNewFile *.h 0put =\"\<nl>#ifndef __\<nl>#define __\<nl>\<nl>\<nl>\#endif\<nl>\<nl>\"|$

:autocmd BufNewFile *.java 0put =\"\/*\<nl>\  ________________________________________________\<nl> \|\<nl> \|     Programme: \<nl> \|     Langage: Java\<nl> \|     Auteur:\<nl> \|\<nl> \|     Fichier:\<nl> \|     Date de modification:\<nl> \|\<nl> \|________________________________________________\<nl>*/\<nl>\<nl>\"|$
:autocmd BufNewFile *.php 0put =\"\<\?php\<nl>/*\<nl>\  ________________________________________________\<nl> \|\<nl> \|     Programme: \<nl> \|     Langage: PHP\<nl> \|     Auteur:\<nl> \|\<nl> \|     Fichier:\<nl> \|     Date de modification:\<nl> \|\<nl> \|________________________________________________\<nl>*/\<nl>\<nl>?>\"|$



set t_Co=256
colorscheme zenburn


"Pour le plugin latex

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


au FileType tex call FT_tex()

function FT_tex() 
        
        "syn region myFold start="\begin {document}" end="\end {document}" transparent fold
        "syn sync fromstart
        "setlocal foldmethod=marker
        
        " on redéfinit le mode quickfix de vim pour gérer du latex
        " les commandes utiles sont : 
        " cc pour afficher l'erreur
        " cn pour afficher l'erreur suivante
        " cp pour afficher l'erreur precedente
        " cl pour afficher la liste des erreurs
        set makeprg=latex\ \\\\nonstopmode\ \\\\input\\{$*}
        set efm=%E!\ LaTeX\ %trror:\ %m,
                \%E!\ %m,
                \%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,
                \%+W%.%#\ at\ lines\ %l--%*\\d,
                \%WLaTeX\ %.%#Warning:\ %m,
                \%Cl.%l\ %m,
                \%+C\ \ %m.,
                \%+C%.%#-%.%#,
                \%+C%.%#[]%.%#,
                \%+C[]%.%#,
                \%+C%.%#%[{}\\]%.%#,
                \%+C<%.%#>%.%#,
                \%C\ \ %m,
                \%-GSee\ the\ LaTeX%m,
                \%-GType\ \ H\ <return>%m,
                \%-G\ ...%.%#,
                \%-G%.%#\ (C)\ %.%#,
                \%-G(see\ the\ transcript%.%#),
                \%-G%*\\s,
                \%+O(%f)%r,
                \%+P(%f%r,
                \%+P\ %\\=(%f%r,
                \%+P%*[^()](%f%r,
                \%+P[%\\d%[^()]%#(%f%r,
                \%+Q)%r,
                \%+Q%*[^()])%r,
                \%+Q[%\\d%*[^()])%r

        " *** Si on est en mode graphique, on modifie les icones de la toolbar *** "

        if has ("gui_running")

                " on enleve la toolbar par défaut, et on mets la notre

                unmenu ToolBar
                unmenu! ToolBar

                " toolbar
        
                amenu 1.10 ToolBar.Open :browse e<CR>
                tmenu ToolBar.Open              Open file
                amenu 1.20 ToolBar.Save :w<CR>
                tmenu ToolBar.Save              Save current file
                amenu 1.30 ToolBar.SaveAll      :wa<CR>
                tmenu ToolBar.SaveAll           Save all files
                amenu 1.40 ToolBar.Undo u
                tmenu ToolBar.Undo              Undo
                amenu 1.50 ToolBar.Redo <C-R>
                tmenu ToolBar.Redo              Redo
                amenu 1.60 ToolBar.Make :make % <CR>
                amenu 1.70 ToolBar.View :!xdvi %<.dvi <CR> 
                amenu 1.80 ToolBar.Print :!dvips %<.dvi <CR>
                amenu 1.90 ToolBar.Xfig :!xfig <CR>

                vmenu 1.100 ToolBar.Bold s\textbf{}<Esc>P
                tmenu ToolBar.Bold      Bold Text
                vmenu 1.100 ToolBar.Italic s\textit{}<Esc>P
                tmenu ToolBar.Italic    Italic
                vmenu 1.100 ToolBar.SmallCaps s\textsc{}<Esc>P
                tmenu ToolBar.SmallCaps         SmallCaps
                vmenu 1.100 ToolBar.Part s\part{}<Esc>P
                tmenu ToolBar.Part      Parts
                vmenu 1.100 ToolBar.Chapter s\chapter{}<Esc>P
                tmenu ToolBar.Chapter   Chapters
                vmenu 1.100 ToolBar.Section s\section{}<Esc>P
                vmenu 1.100 ToolBar.SubSection s\subsection{}<Esc>P
                vmenu 1.100 ToolBar.SubSubSection s\subsubsection{}<Esc>P
                vmenu 1.180 ToolBar.Left S\begin{center}<CR>\end{center}<ESC>P
                vmenu 1.180 ToolBar.Center S\begin{flushleft}<CR>\end{flushleft}<ESC>P 
                vmenu 1.180 ToolBar.Right S\begin{right}<CR>\end{right}<ESC>P
                vmenu 1.180 ToolBar.Tabular :call MakeTab() <CR>

        endif

        " *** on rajoute quelques mapping de touches *** "

		noremap <C-t> :TTemplate <cr>3<cr><cr>
        map <F2> :w<CR>:!pdflatex %<.tex<CR>
        map <F3> :!evince %<.pdf<CR>
        map <F4> :!dvips %<.dvi<CR>
        map <F5> :!xfig<CR>
        map <F6> :!aspell --mode=tex check % <CR> :e!<CR>
        map <F7> :!gaspell --mode=tex %<CR> :e!<CR>
        map <F10> :echo "Fonctions : <F2> make <F3> voir <F4> imprimer <F5> xfig <F6> aspell <F7> gaspell" <CR>
        "map <F10> :call Folding() <CR>
        "setlocal foldmethod=expr
        "setlocal foldexpr=LatexFoldLevel(v:lnum)
        "setlocal foldcolumn=4

        " *** raccourcis non visuels *** "

        "nmap _b !!encapsule "\textbf{" "}" <CR>
        "nmap _i !!encapsule "\textit{" "}" <CR>
        "nmap _sc !!encapsule "\textsc{" "}" <CR>
        "nmap _pa !!encapsule "\part{" "}" <CR>
        "nmap _ch !!encapsule "\chapter{" "}" <CR>
        "nmap _se !!encapsule "\section{" "}" <CR>
        "nmap _s2 !!encapsule "\subsection{" "}" <CR>
        "nmap _s3 !!encapsule "\subsubsection{" "}" <CR>
        "nmap _t !!encapsule "\item " "" <CR>
        "nmap _mc !!encapsule "\% " "" <CR>
        "nmap _ls !!encapsule "\begin{itemize} " "\end{itemize}" -n<CR>
        "nmap _le !!encapsule "\begin{enumerate} " "\end{enumerate}" -n<CR>
        "nmap _vr !!encapsule "\vref{" "}" <CR>

        " *** raccourcis visuels *** "
        

        " on n'utilise _que_ des raccourcis visuels, car on ne modifiera que ce que l'on
        " aura clairement sélectionné. c'est comme ça et pi c'est tout, na.
        " (nan mais c'est vrai aussi, quoi.)

        " bref. Donc on a d'abord des modification de style de texte :
        " gras, italique, petites majuscules, souligné, à l'indice, à l'exposant.

        vn _b s\textbf{}<ESC>P          " gras
        vn _i s\textit{}<ESC>P          " italique
        vn _sc s\textsc{}<ESC>P         " petites majuscules

        " on a ensuite des modifications 'visuelles' :

        vn _pc S\begin{center}<CR>\end{center}<ESC>P            " On centre le texte
        vn _pl S\begin{flushleft}<CR>\end{flushleft}<ESC>P      " On aligne le texte à gauche
        vn _pr S\begin{right}<CR>\end{right}<ESC>P              " On aligne le texte à droite
        vn _pv S\begin{verbatim}<CR>\end{verbatim}<ESC>P        " On mets le texte en mode verbatim
        vn _fg S\begin{figure}[h]<CR>\end{figure}<ESC>P         " hmpf. une figure.

        " voici ensuite les modifications 'structurelles'
        " partie, chapitre, section, subsection, subsubsection

        vn _pa s\part{}<ESC>P           " partie
        vn _ch s\chapter{}<ESC>P        " chapitre
        vn _se s\section{}<ESC>P        " section
        vn _s2 s\subsection{}<ESC>P     " sous-section
        vn _s3 s\subsubsection{}<ESC>P  " sous-sous-section

        " puis les modifications de 'navigation' : 
        " notes de pied de page, références.
        
        vn _ft s\footnote{}<ESC>P       " note de bas de page
        vn _lb s\label{}<ESC>P          " on définit un label
        vn _rf s\ref{}<ESC>P            " on affiche une référence
        vn _vr s\vref{}<ESC>P           " on affiche une vréférence

        " Nous voici aux listes...

        vn _pt :call MakeList("","", "\\\\item ") <CR>  " rajoute des \item devant chaque ligne  
        vn _mc :call MakeList("","", "\% ") <CR>        " rajoute des % devant chaque ligne     
        vn _xc :call RemoveComments() <CR>              " enlève des % devant chaque ligne

        " là on définit une liste complète
        " avec des tirets ... 
        vn _ls :call MakeList("\\begin{itemize}","\\end{itemize}", "\\\\item ") <ESC> :'>+2 <CR> 
        " ... et par énumération
        vn _le :call MakeList("\\begin{enumerate}","\\end{enumerate}", "\\\\item ") <ESC> :'>+2 <CR>

        " Enfin, on finit par le plat de résistance, un tableau : 

        vn _mt :call MakeTab() <CR>

endfunction 

function MakeTab () range 

        let pos = 0
        let nb_colonnes = 0
        let ret = 0

        " pour vim >= 6, cette macro devrait marcher pour déterminer
        " automatiquement le nombre de colonnes du tableau : 
        " let ret = match(getline(a:firstline),'\t',pos) 
        " while (ret != -1)
        "       let pos = ret + 1
        "       let ret = match(getline(a:firstline),'\t',pos)
        "       let nb_colonnes = nb_colonnes + 1
        " endwhile      
        " let nb_colonnes = nb_colonnes + 1

        " sinon, on demande le nombre à l'utilisateur : 
        let nb_colonnes = input ("Entrez le nombre de colonnes du tableau : ")
        
        let pos = 0
        let options = "{|"      
        while (pos < nb_colonnes)
                let options = options . "c"
                let pos = pos + 1
        endwhile
        let options = options . "|}"
        
        "let sep = confirm ("Séparation :","&Contour\n&Aucune\nA Chaque &Ligne")
        let sep = 1
         
        let text1 = "\\begin{tabular}" . options 
        let text2 = "\\end{tabular}"
        if (sep == 3)
                exe (a:firstline) . "," . a:lastline . 's/$/\\\\\\hline' 
        else
                exe (a:firstline) . "," . a:lastline . 's/$/\\\\' 
        endif
        exe (a:firstline) . "," . a:lastline . 's/\t\+/ \& /g' 
        if ((sep == 1) || (sep == 3))
                exe append (a:firstline -1 ,"\\hline")  
                exe append (a:firstline +1 ,"\\hline")  
                exe append (a:firstline -1 ,text1)      
                if (sep == 1) 
                        exe append (a:lastline +3 ,"\\hline")   
                        exe append (a:lastline +4, text2) 
                else
                        exe append (a:lastline +3, text2) 
                endif
        else
                exe append (a:firstline -1 ,text1)      
                exe append (a:lastline +1, text2) 
        endif
endfunction 

function MakeList (text1, text2, text3) range 
        exe (a:firstline) . "," . a:lastline . 's/^/' . a:text3 
        if (strlen(a:text1) > 0)
                exe append (a:firstline -1 ,a:text1)    
        endif
        if (strlen(a:text2) > 0)
                exe append (a:lastline +1, a:text2) 
        endif
endfunction 

autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=fr
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=fr

