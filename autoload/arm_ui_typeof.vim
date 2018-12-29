highlight! link FZFMerlinHighlight Visual

function! s:show_typeof(v) abort
  call arm_highlight#highlight(
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
  let l:input = join(getline(1,'$'), "\n")
  let l:json = system(
          \ arm_merlin#exec(
          \   'server'
          \ , 'type-enclosing'
          \ , '-filename' , fnameescape(l:fname)
          \ , '-index' , 0
          \ , '-verbosity' , string(a:verbosity)
          \ , '-position' , a:line . ':' . (a:col - 1))
        \, l:input)
  let l:resp = json_decode(l:json)
  return l:resp
endfunction

function! arm_ui_typeof#typeof(...)
  let [line, col] = getcurpos()[1:2]

  if exists("b:arm_typeof")
    let prev = b:arm_typeof
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
    let b:arm_typeof = {'resp': resp, 'verbosity': 0, 'line': line, 'col': col}
    call s:show_typeof(v)
  else
    call ale#util#ShowMessage("<cannot query type>")
  endif
endfunction

function! arm_ui_typeof#type(...)
  let fname = expand("%:p")
  let [line, col] = getcurpos()[1:2]
  let input = join(getline(1,'$'), "\n")
  let expr = join(a:000, " ")
  let json = system(
          \ arm_merlin#exec(
          \   'server'
          \ , 'type-expression'
          \ , '-expression', shellescape(expr)
          \ , '-filename' , fnameescape(fname)
          \ , '-position' , line . ':' . (col - 1))
        \, l:input)
  let resp = json_decode(json)
  call ale#util#ShowMessage(resp.value)
endfunction
