function! reason_mode_ide#merlin#exec(args) abort
  return esyapi#exec(['ocamlmerlin', 'server'] + a:args)
endfunction

function! reason_mode_ide#merlin#run_with_current(args) abort
  let input = join(getline(1,'$'), "\n")
  let data = esyapi#exec(['ocamlmerlin', 'server'] + a:args, input)
  return json_decode(data)
endfunction

function! reason_mode_ide#merlin#complete_prefix(prefix) abort
  let [line, col] = getcurpos()[1:2]
  let input = join(getline(1,'$'), "\n")
  let fname = expand("%:p")
  let args = [
    \   'complete-prefix'
    \ , '-position' , line . ':' . (col - 1)
    \ , '-filename', fnameescape(fname)
    \ , '-doc' , 'n'
    \ , '-verbosity' , '0'
    \ ]
  if !empty(a:prefix)
    call add(args, '-prefix')
    call add(args, a:prefix)
  endif
  let resp = reason_mode_ide#merlin#run_with_current(args)
  return resp
endfunction

function! reason_mode_ide#merlin#locate() abort
  let [line, col] = getcurpos()[1:2]
  let input = join(getline(1,'$'), "\n")
  let fname = expand("%:p")
  let args = [
    \   'locate'
    \ , '-look-for' , 'ml'
    \ , '-position' , line . ':' . (col - 1)
    \ , '-filename', fnameescape(fname)
    \ ]
  let resp = reason_mode_ide#merlin#run_with_current(args)
  return resp
endfunction

function! reason_mode_ide#merlin#search_by_polarity(query) abort
  let [line, col] = getcurpos()[1:2]
  let input = join(getline(1,'$'), "\n")
  let cmd = reason_mode_ide#merlin#exec([
        \   'search-by-polarity'
        \ , '-query' , string(a:query)
        \ , '-position' , line . ':' . (col - 1)
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! reason_mode_ide#merlin#list_modules() abort
  let input = join(getline(1,'$'), "\n")
  let cmd = reason_mode_ide#merlin#exec([
        \   'list-modules'
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! reason_mode_ide#merlin#occurrences() abort
  let [line, col] = getcurpos()[1:2]
  let fname = expand("%:p")
  let json = reason_mode_ide#merlin#run_with_current([
        \   'occurrences'
        \ , '-filename', fnameescape(fname)
        \ , '-identifier-at', line . ':' . (col - 1)
        \])
  return json
endfunction

function! reason_mode_ide#merlin#outline() abort
  let fname = expand("%:p")
  let json = reason_mode_ide#merlin#run_with_current([
        \   'outline'
        \ , '-filename', fnameescape(fname)
        \])
  return json
endfunction
