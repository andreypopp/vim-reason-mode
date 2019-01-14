call ale#linter#Define('reason', {
  \   'name': 'reason-mode/reason/occurrences',
  \   'executable': 'true',
  \   'command_callback': function('reason_mode_ui#occurrences#command_callback'),
  \   'callback': function('reason_mode_ui#occurrences#callback'),
  \})
