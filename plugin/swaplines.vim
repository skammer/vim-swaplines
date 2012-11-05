if exists("g:loaded_swaplines") || &cp
  finish
endif

let g:loaded_swaplines = 1
let s:keepcpo          = &cpo
set cpo&vim

if !hasmapto(':SwapUp')
  noremap  <silent> <c-s-up> :SwapUp<CR>
  inoremap <silent> <c-s-up> <Esc>:SwapUp<CR>a
  vnoremap <silent> <c-s-up> :SwapUp<CR>
endif

if !hasmapto(':SwapDown')
  noremap  <silent> <c-s-down> :SwapDown<CR>
  inoremap <silent> <c-s-down> <Esc>:SwapDown<CR>a
  vnoremap <silent> <c-s-down> :SwapDown<CR>
endif

com! SwapUp cal swaplines#swap_up()
com! SwapDown cal swaplines#swap_down()

function! s:swap_lines( n1, n2 )
    let line1 = getline( a:n1 )
    let line2 = getline( a:n2 )
    call setline( a:n1, line2 )
    call setline( a:n2, line1 )
endfunction

function! swaplines#swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    let save_cursor = getpos(".")
    call s:swap_lines(n, n - 1)
    let save_cursor[1]-=1
    call setpos('.', save_cursor)
endfunction

function! swaplines#swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    let save_cursor = getpos(".")
    call s:swap_lines(n, n + 1)
    let save_cursor[1]+=1
    call setpos('.', save_cursor)
endfunction

let &cpo= s:keepcpo
unlet s:keepcpo
