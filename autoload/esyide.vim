function! esyide#cmd(cmd) abort
  let esycmd = "esy"
  return fnameescape(esycmd) . " " . join(a:cmd)
endfunction

function! esyide#exec(cmd, ...) abort
  let cmd = esyide#cmd(a:cmd)
  let input = get(a:, 1, 0)
  if input
    return system(cmd)
  else
    return system(cmd, input)
  endif
endfunction
