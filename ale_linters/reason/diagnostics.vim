call ale#linter#Define('reason', {
  \   'name': 'reason-esy-diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('esyide#diagnostics#command_callback'),
  \   'callback': function('esyide#diagnostics#callback'),
  \})

