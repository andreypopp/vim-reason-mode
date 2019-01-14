function! esyide#fix#refmt(buffer) abort
  let ext = expand('#' . a:buffer . ':e')
  if ext ==# 'rei'
    return {
    \   'command': 'esy refmt --interface true'
    \}
  else
    return {
    \   'command': 'esy refmt'
    \}
  endif
endfunction

