call ale#linter#Define('ocaml', {
  \   'name': 'reason-mode/ocaml/codelens',
  \   'executable': 'true',
  \   'command_callback': function('reason_mode_ui#codelens#command_callback'),
  \   'callback': function('reason_mode_ui#codelens#callback'),
  \})

