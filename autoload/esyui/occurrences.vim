function! esyui#occurrences#find() abort
  let b:esyui_occurrences = esyide#merlin#occurrences()
  ALELint
endfunction

function! esyui#occurrences#clear () abort
  let b:esyui_occurrences = {'value': []}
  ALELint
endfunction

function! esyui#occurrences#command_callback (bufnr) abort
  return 'true'
endfunction

function! esyui#occurrences#callback (buffer, lines)
  let l:errors = []

  let occurrences = get(b:, 'esyui_occurrences', {'value': []})

  for item in occurrences.value
    call add(l:errors, {
          \ "text": 'occurrence',
          \ "type": 'I',
          \ "lnum": item.start.line,
          \ "col": item.start.col + 1,
          \ "end_lnum": item.end.line,
          \ "end_col": item.end.col,
          \ })
  endfor

  let b:esyui_occurrences = {'value': []}

  return l:errors
endfunction
