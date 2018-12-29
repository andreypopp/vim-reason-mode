call ale#linter#Define('reason', {
  \   'name': 'reason-esy-occurrences',
  \   'executable': 'true',
  \   'command_callback': function('esyui#occurrences#command_callback'),
  \   'callback': function('esyui#occurrences#callback'),
  \})
