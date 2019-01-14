function! s:get_ns(buffer) abort
  if get(b:, 'reason_mode_ui_codelens_ns', -1) == -1
      " NOTE: This will highlights nothing but will allocate new id
      let b:reason_mode_ui_codelens_ns = nvim_buf_add_highlight(a:buffer, 0, '', 0, 0, -1)
  endif
  return b:reason_mode_ui_codelens_ns
endfunction

function! s:process(ns, buffer, items) abort
  for item in a:items
    if has_key(item, 'type') && !empty(item.type)
      let text = '  ' . substitute(item.type, '\n', ' ', 'g')
      call nvim_buf_set_virtual_text(a:buffer, a:ns, item.start.line - 1, [[text, 'Comment']], {})
    endif
    if has_key(item, 'children')
      call s:process(a:ns, a:buffer, item.children)
    endif
  endfor
endfunction

function! s:clear(buffer) abort
  let ns = s:get_ns(a:buffer)
  call nvim_buf_clear_namespace(a:buffer, ns, 0, -1)
endfunction

function! reason_mode_ui#codelens#command_callback (buffer) abort
  let fname = expand(a:buffer . ':p')
  return esyapi#cmd([
        \ 'ocamlmerlin', 'server', 'outline',
        \ '-filename', fnameescape(fname)
        \])
endfunction

function! reason_mode_ui#codelens#callback (buffer, lines)

  let json = trim(join(a:lines, "\n"))
  if json ==# ''
    return []
  endif
  let resp = json_decode(json)

  call s:clear(a:buffer)
  let ns = s:get_ns(a:buffer)
  call s:process(ns, a:buffer, resp.value)

  return []
endfunction

