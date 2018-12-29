function! arm_merlin#exec(args) abort
  return arm_esy#exec(['ocamlmerlin', 'server'] + a:args)
endfunction

function! arm_merlin#run_with_current(args) abort
  let input = join(getline(1,'$'), "\n")
  let data = arm_esy#exec(['ocamlmerlin', 'server'] + a:args, input)
  return json_decode(data)
endfunction

function! arm_merlin#search_by_polarity(query) abort
  let [line, col] = getcurpos()[1:2]
  let fname = expand("%:p")
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#exec([
        \   'search-by-polarity'
        \ , '-query' , string(a:query)
        \ , '-position' , line . ':' . (col - 1)
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! arm_merlin#complete_prefix(query, kind) abort
  let [line, col] = getcurpos()[1:2]
  let fname = expand("%:p")
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#exec([
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

function! arm_merlin#list_modules() abort
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#exec([
        \   'list-modules'
        \])
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! arm_merlin#occurrences() abort
  let [line, col] = getcurpos()[1:2]
  let json = arm_merlin#run_with_current([
        \ , 'occurrences'
        \ , '-identifier-at', line . ':' . (col - 1)
        \])
  return json
endfunction
