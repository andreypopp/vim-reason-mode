call ale#linter#Define('ocaml', {
  \   'name': 'ocaml-esy-codelens',
  \   'executable': 'true',
  \   'command_callback': function('esyui#codelens#command_callback'),
  \   'callback': function('esyui#codelens#callback'),
  \})

