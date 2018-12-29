function! s:accept(line)
  let find = '\(\d\+\):\(\d\+\) '
  let m = matchstr(a:line, find)
  let line = substitute(m, find, '\1', '')
  let col = substitute(m, find, '\2', '')
  call cursor(line, col)
endfunction

function! s:format_name(item)
  let l:prefix = a:item.kind . " "
  let l:suffix = ""
  if a:item.kind ==# "Module"
    let l:prefix = "module "
  elseif a:item.kind ==# "Value"
    let l:prefix = "val "
    let l:suffix = " : ..."
  elseif a:item.kind ==# "Type"
    let l:prefix = "type "
  elseif a:item.kind ==# "Constructor"
    let l:prefix = "| "
    let l:suffix = " of ..."
  elseif a:item.kind ==# "Label"
    let l:prefix = "{ "
    let l:suffix = "; ... }"
  elseif a:item.kind ==# "Signature"
    let l:prefix = "sig "
  endif
  return l:prefix . a:item.name . l:suffix
endfunction

function! s:process(lines, items, trace)
  for l:item in a:items
    let l:name = s:format_name(l:item)
    if empty(a:trace)
      let l:prev = ""
    else
      let l:prev = join(a:trace, " > ") . " > "
    endif
    if has_key(l:item, 'start')
      let l:line = printf(
              \ "%d:%d %s%s",
              \ l:item.start.line,
              \ l:item.start.col,
              \ l:prev,
              \ l:name
            \)
    else
      let l:line = printf(
              \ "%s%s",
              \ l:prev,
              \ l:name
            \)
    endif
    call add(a:lines, l:line)
    let l:nexttrace = copy(a:trace)
    call add(l:nexttrace, l:name)
    if has_key(l:item, 'children')
      call s:process(a:lines, l:item.children, l:nexttrace)
    endif
  endfor
endfunction

function! esyui#outline#module_outline(...)
  let fname = expand("%:p")
  let resp = esy#merlin#run_with_current(['outline', '-filename', l:fname])
  let value = l:resp.value

  let lines = []
  call s:process(lines, value, [])

  return fzf#run(fzf#wrap('esyui_outline', {
  \ 'source':  reverse(lines),
  \ 'sink':   function('s:accept'),
  \ 'options': '--no-multi --tiebreak=index --header-lines=0 -d " " --with-nth "2.." --prompt="MerlinOutline> "',
  \}))
endfunction

function! esyui#outline#modules_outline(...)
  let resp = esy#merlin#list_modules()
  let lines = []
  call s:process(lines, resp.value.entries, [])

  return fzf#run(fzf#wrap('esyui_outline', {
  \ 'source':  reverse(lines),
  \ 'sink':   function('s:accept'),
  \ 'options': '--no-multi --tiebreak=index --header-lines=0 -d " " --with-nth "2.." --prompt="MerlinOutline> "',
  \}))
endfunction
