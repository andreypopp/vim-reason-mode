call ale#linter#Define('reason', {
  \   'name': 'reason-esy-codelens',
  \   'executable': 'true',
  \   'command_callback': function('esyui#codelens#command_callback'),
  \   'callback': function('esyui#codelens#callback'),
  \})
