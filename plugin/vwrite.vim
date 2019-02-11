set nonumber norelativenumber
set spell spelllang=en_gb
 
nnoremap <h1 :call CreateHeading(1)<CR>
nnoremap <h2 :call CreateHeading(2)<CR>
nnoremap <h3 :call CreateHeading(3)<CR>

func! CreateHeading(lvl)
	execute "normal! yy"
	if a:lvl ==# 1
		execute "normal! pVr="
	elseif a:lvl ==# 2
		execute "normal! pVr-"
	elseif a:lvl ==# 3
		execute "normal! 0i###"
	endif
	execute "normal! o\n"
endfunc
