let g:listing = 0 
let g:bullet_type = "-"
 
let g:table = 0
let g:table_columns = 0
let g:table_rows = 0
let g:cell_width = 0
let g:cell_height = 0

set nonumber norelativenumber
set spell spelllang=en_gb
 
inoremap <CR> <C-o>:call ProcessEnter()<CR>

nnoremap <silent> <TAB> :call ProcessTabs()<CR>
nnoremap <silent> <S-TAB> :call ProcessSTabs()<CR>

lmap <silent> <TAB> <C-o>:call NxtCol()<CR>

command! -nargs=1 Heading call CreateHeading(<f-args>)
command! -nargs=1 BulletSelect call SelectBulletType(<f-args>)
command! InitTable call InitTable()

let timer = timer_start(1000, 'EnterOnLineEnd', {'repeat':-1})
func! EnterOnLineEnd(timer)
	if(col('.') > 90)
		while(col('.') > 90)
			execute "normal! b"
		endwhile
		execute "normal! d$o"
		execute "normal! pA"
	endif
endfunc

func! ProcessEnter()
	if g:table == 1
		call Tabulate()
	elseif g:listing >= 1
		call Bullets()
	endif
	if g:listing == 0 && g:table == 0
		execute "normal! gi\n"
	endif
endfunc

func! ProcessTabs()
	if g:table == 1
		call DCDriver()
		startgreplace
	elseif g:listing == 1
		call IncreaseListingLevel()
	endif
endfunc

func! ProcessSTabs()
	if g:table == 1
		let g:table = 0
		execute "normal! A\n"
	elseif g:listing >= 1
		call DecreaseListingLevel()
	endif
endfunc

func! CreateHeading(lvl)
	execute "normal! yy"
	if a:lvl ==# 1
		execute "normal! pVr="
	elseif a:lvl ==# 2
		execute "normal! pVr-"
	elseif a:lvl ==# 3
		execute "normal! 0i###"
	endif
	startinsert!
endfunc

func! DecreaseListingLevel()
	if g:listing > 0
		let g:listing = g:listing - 1
	endif
endfunc

func! IncreaseListingLevel()
	let g:listing = g:listing + 1
endfunc

func! SelectBulletType(type)
	let g:bullet_type = a:type
endfunc

func! Bullets()
	execute "normal! gi\n"
	let l:i = 0
	while l:i < g:listing
		execute "normal! gi\t"
		let l:i = l:i + 1
	endwhile
	if g:listing > 0
		execute "normal! gi" . g:bullet_type . " "
	endif
endfunc

func! AddColumn()
	let g:table_columns = g:table_columns + 1
endfunc
 
func! IncreaseCellWidth()
	let g:cell_width = g:cell_width + 1
endfunc
 
func! IncreaseCellHeight()
	let g:cell_height = g:cell_height + 1
endfunc

func! InitTable()
	let g:table = 1
	let g:cell_width = 2
	let g:cell_height = 1
	call Tabulate()
endfunc

func! DCDriver()
	execute "normal! k"
	call DrawNewColumn()
	startgreplace
	let g:table_columns += 1
endfunc

func! DrawNewColumn()
	let l:i = 1
	execute "normal! A---"
	while l:i < g:cell_width
		execute "normal! A----"
		let l:i += 1
	endwhile
	execute "normal! A+\<ESC>j"

	let l:j = 0
	while l:j < g:cell_height*g:table_rows
		let l:i = 0
		while l:i < g:cell_width
			execute "normal! A\t"
			let l:i += 1
		endwhile
		execute "normal! A|\<ESC>j"
		let l:j += 1
	endwhile

	let l:i = 1
	execute "normal! A---"
	while l:i < g:cell_width
		execute "normal! A----"
		let l:i += 1
	endwhile
	execute "normal! A+\<ESC>khh"
endfunc

func! DrawNewRow()
	let l:i = 0
	execute "normal! j"
	execute "normal! 0ld$"
	while l:i < g:cell_height
		execute "normal! o|"
		let l:i += 1
	endwhile
	execute "normal! o+"
	execute "normal! k"
	execute "normal! " . g:cell_height . "k"
	let l:i = 0
	while l:i < g:table_columns
		call DrawNewColumn()
		execute "normal! k"
		let l:i += 1
	endwhile
endfunc

func! Tabulate()
	let l:i = 0
	if g:table_columns == 0
		execute "normal! o+-------+\n|\t\t|\n+-------+"
		execute "normal! k0l"
		startgreplace
		let g:table_columns = 1
		let g:table_rows = 1
	else
		call DrawNewRow()
		execute "normal! j0l"
		startgreplace
	endif
endfunc

func! EndTable()
	execute "normal! jA\n"
	let g:table = 0
	let g:table_columns = 0
	let g:table_rows = 0
	let g:cell_width = 0
	let g:cell_height = 0
endfunc

func! NxtCol()
	execute "normal! jf+kl"
	startgreplace
endfunc
