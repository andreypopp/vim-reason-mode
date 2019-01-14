function! s:get_ns(buffer) abort
  if get(b:, 'esyui_codelens_ns', -1) == -1
      " NOTE: This will highlights nothing but will allocate new id
      let b:esyui_codelens_ns = nvim_buf_add_highlight(a:buffer, 0, '', 0, 0, -1)
  endif
  return b:esyui_codelens_ns
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
  let b:esyui_codelens_items = {'value': []}
  let ns = s:get_ns(a:buffer)
  call nvim_buf_clear_namespace(a:buffer, ns, 0, -1)
endfunction

function! esyui#codelens#command_callback (bufnr) abort
  let b:esyui_codelens_items = esyide#merlin#outline()
  return 'true'
endfunction

function! esyui#codelens#callback (buffer, lines)
  let codelens = get(b:, 'esyui_codelens_items', {'value': []})

  call s:clear(a:buffer)
  let ns = s:get_ns(a:buffer)
  call s:process(ns, a:buffer, codelens.value)

  let b:esyui_codelens_items = {'value': []}

  return []
endfunction

