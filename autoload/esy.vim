function! esy#cmd(cmd) abort
  let esycmd = "esy"
  return fnameescape(esycmd) . " " . join(a:cmd)
endfunction

function! esy#exec(cmd, ...) abort
  let cmd = esy#cmd(a:cmd)
  let input = get(a:, 1, 0)
  if input
    return system(cmd)
  else
    return system(cmd, input)
  endif
endfunction
