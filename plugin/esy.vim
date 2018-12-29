command! -bang EsyModuleOutline call esyui#outline#module_outline(<bang>0)
command! -bang EsyTypeOf call esyui#typeof#typeof(<bang>0)
command! -nargs=0 -bang EsyOccurrences call esyui#occurrences#find()
command! -nargs=+ EsyType call esyui#typeof#type(<f-args>)
