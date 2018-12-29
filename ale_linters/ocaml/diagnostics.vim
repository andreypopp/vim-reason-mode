call ale#linter#Define('ocaml', {
  \   'name': 'ocaml-esy-diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('esyide#diagnostics#command_callback'),
  \   'callback': function('esyide#diagnostics#callback'),
  \})
