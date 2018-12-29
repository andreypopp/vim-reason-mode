function! arm_ui_occurrences#find() abort
  let b:arm_occurrences = arm_merlin#occurrences()
  ALELint
endfunction

function! arm_ui_occurrences#clear () abort
  let b:arm_occurrences = {'value': []}
  ALELint
endfunction

function! arm_ui_occurrences#command_callback (bufnr) abort
  return 'true'
endfunction

function! arm_ui_occurrences#callback (buffer, lines)
  let l:errors = []

  let occurrences = get(b:, 'arm_occurrences', {'value': []})

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

  return l:errors
endfunction
