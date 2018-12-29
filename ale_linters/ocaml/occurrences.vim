call ale#linter#Define('ocaml', {
  \   'name': 'ocaml-esy-occurrences',
  \   'executable': 'true',
  \   'command_callback': function('esyui#occurrences#command_callback'),
  \   'callback': function('esyui#occurrences#callback'),
  \})
