command! -bang EsyIDEModuleOutline call esyui#outline#module_outline(<bang>0)
command! -bang EsyIDETypeOf call esyui#typeof#typeof(<bang>0)
command! -nargs=+ EsyIDeType call esyui#typeof#type(<f-args>)
command! -nargs=0 -bang EsyIDEOccurrences call esyui#occurrences#find()
command! -nargs=0 -bang EsyIDEOccurrences call esyui#occurrences#find()
command! -nargs=0 -bang EsyIDEJumpToDefinition call esyui#locate#jumpToDefintion()

setlocal omnifunc=esyui#completion#omnifunc
