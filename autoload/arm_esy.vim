function! arm_esy#exec(...) abort
  let esycmd = "esy"
  return system(fnameescape(esycmd) . " " . join(a:000))
endfunction


