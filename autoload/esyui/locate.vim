function! esyui#locate#jumpToDefintion() abort
  let resp = esyide#merlin#locate()

  " 'Already at defintion point' or something other worth reporting to user
  if type(resp.value) == v:t_string
    echo resp.value
    return
  endif

  let current_file = expand('%:p')

  let line = resp.value.pos.line
  let col = resp.value.pos.col + 1

  if has_key(resp.value, 'file') && !(current_file ==# resp.value.file)
    let cmd = ':edit +call\ cursor(' . line . ',' . col . ') ' . fnameescape(resp.value.file)
    execute cmd
  else
    call cursor(line, col)
  endif
endfunction
