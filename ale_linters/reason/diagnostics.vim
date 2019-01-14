call ale#linter#Define('reason', {
  \   'name': 'reason-mode/reason/diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('reason_mode_ide#diagnostics#command_callback'),
  \   'callback': function('reason_mode_ide#diagnostics#callback'),
  \})

