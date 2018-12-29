command! -bang ArmModuleOutline call arm_ui_outline#module_outline(<bang>0)
command! -bang ArmTypeOf call arm_ui_typeof#typeof(<bang>0)
command! -nargs=0 -bang ArmOccurrences call arm_ui_occurrences#find()
command! -nargs=+ ArmType call arm_ui_typeof#type(<f-args>)

call ale#linter#Define('ocaml', {
  \   'name': 'arm/ocaml/occurrences',
  \   'executable': 'true',
  \   'command_callback': function('arm_ui_occurrences#command_callback'),
  \   'callback': function('arm_ui_occurrences#callback'),
  \})
