call ale#linter#Define('reason', {
  \   'name': 'reason-arm-diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('arm_ui_diagnostics#command_callback'),
  \   'callback': function('arm_ui_diagnostics#callback'),
  \})

