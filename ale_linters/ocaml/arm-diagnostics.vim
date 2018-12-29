call ale#linter#Define('ocaml', {
  \   'name': 'ocaml-arm-diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('arm_ui_diagnostics#command_callback'),
  \   'callback': function('arm_ui_diagnostics#callback'),
  \})
