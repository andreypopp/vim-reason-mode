function! arm_merlin#find_executable() abort
  if exists("b:merlin_command")
    return b:merlin_command
  else
    let b:merlin_command = arm_utils#strip(arm_esy#exec("which", "ocamlmerlin"))
    return b:merlin_command
  endif
endfunction

function! arm_merlin#exec(...) abort
  return arm_merlin#find_executable() . " " . join(a:000)
endfunction

function! arm_merlin#run_with_current(...) abort
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#find_executable() . " " . join(a:000)
  let data = system(cmd, input)
  let json = json_decode(data)
  return json
endfunction

function! arm_merlin#search_by_polarity(query) abort
  let [line, col] = getcurpos()[1:2]
  let fname = expand("%:p")
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#exec(
        \   'server'
        \ , 'search-by-polarity'
        \ , '-query' , string(a:query)
        \ , '-position' , line . ':' . (col - 1))
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! arm_merlin#complete_prefix(query, kind) abort
  let [line, col] = getcurpos()[1:2]
  let fname = expand("%:p")
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#exec(
        \   'server'
        \ , 'complete-prefix'
        \ , '-type' , 'false'
        \ , '-kind' , string(a:kind)
        \ , '-prefix' , string(a:query)
        \ , '-position' , line . ':' . (col - 1))
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! arm_merlin#list_modules() abort
  let input = join(getline(1,'$'), "\n")
  let cmd = arm_merlin#exec(
        \   'server'
        \ , 'list-modules'
        \)
  let json = system(cmd, input)
  let resp = json_decode(json)
  return resp
endfunction

function! arm_merlin#occurrences() abort
  let [line, col] = getcurpos()[1:2]
  let json = arm_merlin#run_with_current(
        \   'server'
        \ , 'occurrences'
        \ , '-identifier-at', line . ':' . (col - 1)
        \)
  return json
endfunction
