function! esyide#diagnostics#command_callback (bufnr) abort
  let fname = expand("%:p")
  return esyide#cmd([
        \ 'ocamlmerlin', 'server', 'errors',
        \ '-filename', fnameescape(fname)
        \])
endfunction

function! esyide#diagnostics#callback (buffer, lines) abort
  let l:errors = []
  let l:json = esyide#utils#strip(join(a:lines, "\n"))
  if l:json ==# ''
    return []
  endif

  let resp = json_decode(l:json)

  if resp.class ==# 'exception'
    " TODO: log exception here
    call ale#util#ShowMessage("esyide#diagnostics: cannot query for diagnostics")
    return []
  endif

  let l:dummy_loc = {'line': 1, 'col': -1}


  for l:item in resp.value

    if l:item.type ==# 'warning'
      let l:type = 'W'
    else
      let l:type = 'E'
    endif

    let l:message = join(split(l:item.message, "\n"), " ")
    let l:message = substitute(l:message, ' \+', ' ', 'g')

    " Signature mismatch errors span too many lines so we limit it to report
    " only start loc.
    if l:message[0] =~ "^Signature mismatch"
      call add(l:errors, {
            \ "text": l:message,
            \ "type": l:type,
            \ "lnum": get(l:item, 'start', dummy_loc).line,
            \ "col": get(l:item, 'start', dummy_loc).col + 1,
            \ })
    else
      call add(l:errors, {
            \ "text": l:message,
            \ "type": l:type,
            \ "lnum": get(l:item, 'start', dummy_loc).line,
            \ "col": get(l:item, 'start', dummy_loc).col + 1,
            \ "end_lnum": get(l:item, 'end', dummy_loc).line,
            \ "end_col": get(l:item, 'end', dummy_loc).col,
            \ })
    endif

    for l:sub in l:item.sub
      call add(l:errors, {
            \ "text": l:sub.message,
            \ "type": l:type,
            \ "lnum": get(l:sub, 'start', dummy_loc).line,
            \ "col": get(l:sub, 'start', dummy_loc).col + 1,
            \ "end_lnum": get(l:sub, 'end', dummy_loc).line,
            \ "end_col": get(l:sub, 'end', dummy_loc).col,
            \ })
    endfor
  endfor

  return l:errors
endfunction
