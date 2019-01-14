function! reason_mode_ui#locate#jumpToDefintion() abort
  let resp = reason_mode_ide#merlin#locate()

  " 'Already at defintion point' or something other worth reporting to user
  if type(resp.value) == v:t_string
    echo resp.value
  else
    let current_file = expand('%:p')

    let line = resp.value.pos.line
    let col = resp.value.pos.col + 1

    if has_key(resp.value, 'file') && !(current_file ==# resp.value.file)
      let cmd = ':edit +call\ cursor(' . line . ',' . col . ') ' . fnameescape(resp.value.file)
      execute cmd
    else
      let cmd = 'normal ' . line . 'G' . col . '|'
      execute cmd
    endif
  endif
endfunction
