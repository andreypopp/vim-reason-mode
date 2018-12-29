function! esy#merlin#exec(args) abort
  return esy#exec(['ocamlmerlin', 'server'] + a:args)
endfunction

function! esy#merlin#run_with_current(args) abort
  let input = join(getline(1,'$'), "\n")
  let data = esy#exec(['ocamlmerlin', 'server'] + a:args, input)
  return json_decode(data)
endfunction

function! esy#merlin#search_by_polarity(query) abort
  let [line, col] = getcurpos()[1:2]
  let input = join(getline(1,'$'), "\n")
  let cmd = esy#merlin#exec([
        \   'search-by-polarity'
        \ , '-query' , string(a:query)
        \ , '-position' , line . ':' . (col - 1)
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! esy#merlin#complete_prefix(query, kind) abort
  let [line, col] = getcurpos()[1:2]
  let input = join(getline(1,'$'), "\n")
  let cmd = esy#merlin#exec([
        \   'complete-prefix'
        \ , '-type' , 'false'
        \ , '-kind' , string(a:kind)
        \ , '-prefix' , string(a:query)
        \ , '-position' , line . ':' . (col - 1)
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! esy#merlin#list_modules() abort
  let input = join(getline(1,'$'), "\n")
  let cmd = esy#merlin#exec([
        \   'list-modules'
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! esy#merlin#occurrences() abort
  let [line, col] = getcurpos()[1:2]
  let fname = expand("%:p")
  let json = esy#merlin#run_with_current([
        \   'occurrences'
        \ , '-filename', fnameescape(fname)
        \ , '-identifier-at', line . ':' . (col - 1)
        \])
  return json
endfunction
