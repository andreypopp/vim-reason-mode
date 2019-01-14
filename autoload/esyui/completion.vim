" copied from merlin runtime

function! esyui#completion#omnifunc(findstart, base)
  if a:findstart
    " Synchronize merlin before completion, since vim modify the buffer
    " (prefix is removed)
    " Locate the start of the item, including ".", "->" and "[...]".
    let line = getline('.')
    let start = col('.') - 1
    let lastword = -1
    while start > 0
      if line[start - 1] =~ '\(\w\|''\)'
        let start -= 1
      elseif line[start - 1] =~ '\.'
        if lastword == -1
          let lastword = start
        endif
        let start -= 1
      else
        break
      endif
    endwhile
    if start > 0 && line[start - 1] =~ '[~?`]'
      let start -= 1
    endif

    let s:compl_base = strpart(line, start, col('.') - 1 - start)

    " Return the column of the last word, which is going to be changed.
    " Remember the text that comes before it in s:compl_prefix.
    if lastword == -1
      let s:compl_prefix = ''
      let s:compl_suffix = s:compl_base
    else
      let s:compl_prefix = strpart(line, start, lastword - start)
      let s:compl_suffix = strpart(line, lastword, col('.') - 1 - lastword)
    endif

    " Query completion
    let s:compl_result = esyide#merlin#complete_prefix(s:compl_base)

    if lastword == -1
      return start
    else
      return lastword
    end
  endif

  let words = []
  for entry in s:compl_result.value.entries
    call add(words, {
          \ 'word': entry.name,
          \ 'menu': tolower(entry.kind),
          \ 'info': '',
          \ 'kind': '',
          \ })
  endfor

  return {'words': words, 'refresh': 'always'}
endfunction
