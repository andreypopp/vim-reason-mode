call ale#linter#Define('ocaml', {
  \   'name': 'reason-mode/ocaml/diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('reason_mode_ide#diagnostics#command_callback'),
  \   'callback': function('reason_mode_ide#diagnostics#callback'),
  \})
