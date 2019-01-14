call ale#linter#Define('reason', {
  \   'name': 'reason-mode/reason/codelens',
  \   'executable': 'true',
  \   'command_callback': function('reason_mode_ui#codelens#command_callback'),
  \   'callback': function('reason_mode_ui#codelens#callback'),
  \})
