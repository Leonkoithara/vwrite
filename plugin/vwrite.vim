let g:listing = 0 

set nonumber norelativenumber
set spell spelllang=en_gb
 
inoremap <CR> <C-o>:call Bullets(0)<CR>

nnoremap <silent> <TAB> :call IncreaseListingLevel()<CR>
nnoremap <silent> <S-TAB> :call DecreaseListingLevel()<CR>

command! -nargs=1 Heading call CreateHeading(<f-args>)

func! CreateHeading(lvl)
	execute "normal! yy"
	if a:lvl ==# 1
		execute "normal! pVr="
	elseif a:lvl ==# 2
		execute "normal! pVr-"
	elseif a:lvl ==# 3
		execute "normal! 0i###"
	endif
	execute "normal! A"
endfunc

func! DecreaseListingLevel()
	let g:listing = g:listing - 1
endfunc

func! IncreaseListingLevel()
	let g:listing = g:listing + 1
endfunc

func! Bullets(type)
	execute "normal! gi\n"
	let l:i = 0
	while i < g:listing
		execute "normal! gi\t"
		let l:i = l:i + 1
	endwhile
	if a:type == 1
		execute "normal! gi\t* "
		let g:listing = g:listing + 1
	else
		if g:listing > 0
			execute "normal! gi* "
		endif
	endif
endfunc

func! EchoListing()
	:echo g:listing
endfunc
