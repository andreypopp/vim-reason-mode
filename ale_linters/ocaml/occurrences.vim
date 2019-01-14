call ale#linter#Define('ocaml', {
  \   'name': 'reason-mode/ocaml/occurrences',
  \   'executable': 'true',
  \   'command_callback': function('reason_mode_ui#occurrences#command_callback'),
  \   'callback': function('reason_mode_ui#occurrences#callback'),
  \})
