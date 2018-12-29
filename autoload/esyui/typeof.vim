highlight! link FZFMerlinHighlight Visual

function! s:show_typeof(v) abort
  call esyide#highlight#highlight(
        \ bufnr("%"),
        \ "FZFMerlinHighlight",
        \ a:v.start.line - 1,
        \ a:v.start.col,
        \ a:v.end.line - 1,
        \ a:v.end.col)
  call ale#util#ShowMessage(a:v.type)
endfunction

function! s:call_merlin_typeof(verbosity, line, col) abort
  let l:fname = expand("%:p")
  return esyide#merlin#run_with_current([
        \   'type-enclosing'
        \ , '-filename' , fnameescape(l:fname)
        \ , '-index' , 0
        \ , '-verbosity' , string(a:verbosity)
        \ , '-position' , a:line . ':' . (a:col - 1)
        \])
endfunction

function! esyui#typeof#typeof(...)
  let [line, col] = getcurpos()[1:2]

  if exists("b:esyui_typeof")
    let prev = b:esyui_typeof
    if line == prev.line && col == prev.col
      let verbosity = prev.verbosity + 1
      let resp = s:call_merlin_typeof(verbosity, line, col)
      if len(resp.value)
        call s:show_typeof(resp.value[0])
      else
        call ale#util#ShowMessage("<cannot query type>")
      endif
      let prev.verbosity = verbosity
      return
    endif
  endif

  let resp = s:call_merlin_typeof(0, line, col)
  if len(resp.value)
    let v = resp.value[0]
    let b:esyui_typeof = {'resp': resp, 'verbosity': 0, 'line': line, 'col': col}
    call s:show_typeof(v)
  else
    call ale#util#ShowMessage("<cannot query type>")
  endif
endfunction

function! esyui#typeof#type(...)
  let fname = expand("%:p")
  let [line, col] = getcurpos()[1:2]
  let expr = join(a:000, " ")
  let resp = esyide#merlin#run_with_current([
          \   'type-expression'
          \ , '-expression', shellescape(expr)
          \ , '-filename' , fnameescape(fname)
          \ , '-position' , line . ':' . (col - 1)
        \])
  call ale#util#ShowMessage(resp.value)
endfunction
