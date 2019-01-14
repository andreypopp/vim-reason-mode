function! reason_mode_ui#occurrences#find() abort
  let b:reason_mode_ui_occurrences = reason_mode_ide#merlin#occurrences()
  ALELint
endfunction

function! reason_mode_ui#occurrences#clear () abort
  let b:reason_mode_ui_occurrences = {'value': []}
  ALELint
endfunction

function! reason_mode_ui#occurrences#command_callback (bufnr) abort
  return 'true'
endfunction

function! reason_mode_ui#occurrences#callback (buffer, lines)
  let l:errors = []

  let occurrences = get(b:, 'reason_mode_ui_occurrences', {'value': []})

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

  let b:reason_mode_ui_occurrences = {'value': []}

  return l:errors
endfunction
