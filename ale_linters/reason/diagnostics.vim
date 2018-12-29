call ale#linter#Define('reason', {
  \   'name': 'reason-esy-diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('esy#diagnostics#command_callback'),
  \   'callback': function('esy#diagnostics#callback'),
  \})

