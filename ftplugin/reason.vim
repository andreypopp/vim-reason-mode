command! -bang ReasonModeModuleOutline call reason_mode_ui#outline#module_outline(<bang>0)
command! -bang ReasonModeTypeOf call reason_mode_ui#typeof#typeof(<bang>0)
command! -nargs=+ ReasonModeType call reason_mode_ui#typeof#type(<f-args>)
command! -nargs=0 -bang ReasonModeOccurrences call reason_mode_ui#occurrences#find()
command! -nargs=0 -bang ReasonModeJumpToDefinition call reason_mode_ui#locate#jumpToDefintion()

setlocal omnifunc=reason_mode_ui#completion#omnifunc

nnoremap <silent> <buffer> <Plug>(reason_mode_module_outline)    :ReasonModeModuleOutline<CR>
nnoremap <silent> <buffer> <Plug>(reason_mode_typeof)            :ReasonModeTypeOf<CR>
nnoremap <silent> <buffer> <Plug>(reason_mode_occurrences)       :ReasonModeOccurrences<CR>
nnoremap <silent> <buffer> <Plug>(reason_mode_jump_to_definiton) :ReasonModeJumpToDefinition<CR>
