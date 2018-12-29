function! esyide#utils#strip(v) abort
  return substitute(a:v, '^[\n\s]*\(.\{-}\)[\n\s]*$', '\1', '')
endfunction
