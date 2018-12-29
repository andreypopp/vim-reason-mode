call ale#linter#Define('ocaml', {
  \   'name': 'ocaml-esy-diagnostics',
  \   'executable': 'true',
  \   'command_callback': function('esy#diagnostics#command_callback'),
  \   'callback': function('esy#diagnostics#callback'),
  \})
