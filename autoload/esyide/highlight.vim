function! esyide#highlight#clear() abort
  let buf = bufnr("%")
  call nvim_buf_clear_highlight(buf, -1, 0, -1)
endfunction

function! esyide#highlight#clear_ns(ns) abort
  let buf = bufnr("%")
  call nvim_buf_clear_highlight(buf, a:ns, 0, -1)
endfunction

function! esyide#highlight#highlight(ns, buf, highlight, sline, scol, eline, ecol) abort
  silent! call nvim_buf_clear_highlight(a:buf, a:ns, 0, -1)
  if a:sline == a:eline
    call nvim_buf_add_highlight(
          \ a:buf, a:ns, a:highlight,
          \ a:sline, a:scol, a:ecol
          \ )
  else
    call nvim_buf_add_highlight(
          \ a:buf, a:ns, a:highlight,
          \ a:sline, a:scol, -1
          \ )
    let cur = a:sline + 1
    while cur <= a:eline - 1
      call nvim_buf_add_highlight(
            \ a:buf, a:ns, a:highlight,
            \ cur, 0, -1
            \ )
      let cur += 1
    endwhile
    call nvim_buf_add_highlight(
          \ a:buf, a:ns, a:highlight,
          \ a:eline, 0, a:ecol
          \ )
  endif
endfunction
