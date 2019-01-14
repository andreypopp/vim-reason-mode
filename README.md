# vim-reason-mode

vim-reason-mode is yet another vim mode for Reason/OCaml.

**WARNING:** This vim plugin is highly experimental and I do not recommend using
it. Instead use excellent [jordwalke/vim-reasonml][] which works well out of the
box and does not require any external dependencies.

## Motivation

Why another vim plugin while merlin comes with one and
[jordwalke/vim-reasonml][] wraps it in a nice out of the box experience?

The reasons are:

- This serves as a playgroun for new feature such as codelens using neovim's
  virtualtext feature.

- This plugin doesn't require Python, it's implemented in pure VimL instead.

- ...

## Installation

I use [vim-plug][] and recomment it unless you settled on other option.

Minimal installation:

    Plug 'andreypopp/vim-reason-mode'

Complete installation:

    Plug 'junegunn/fzf'              " needed for :ReasonModeModuleOutline
    Plug 'junegunn/fzf.vim'

    Plug 'w0rp/ale'                  " needed for diagnostics

    Plug 'andreypopp/vim-reason-mode'

[vim-plug]: https://github.com/junegunn/vim-plug

## Configuration

By default vim-reason-mode doesn't provide any functionality w/o configuration.
You need to edit your `.vimrc` to enable specific features.

### Diagnostics

Diagnostics is implemnted using [ALE][] and thus you need to have it installed and then enable
corresponding linters in `.vimrc`:

```
let g:ale_linters = {
\   'ocaml': [
\      'reason-mode/ocaml/diagnostics'
\   ],
\   'reason': [
\      'reason-mode/reason/diagnostics'
\   ],
\   ...
\}
```

### CodeLens: show inferred type annotations

CodeLens is implemented using [ALE][] and thus you need to have it installed and then enable
corresponding linters in `.vimrc`:

```
  let g:ale_linters = {
  \   'ocaml': [
  \      'reason-mode/ocaml/codelens'
  \   ],
  \   'reason': [
  \      'reason-mode/reason/codelens'
  \   ],
  \   ...
  \}
```

### Other (undocumented)

```
au FileType ocaml,reason nmap <silent> <buffer> <C-n>       <Plug>(reason_mode_module_outline)
au FileType ocaml,reason nmap <silent> <buffer> t           <Plug>(reason_mode_typeof)
au FileType ocaml,reason nmap <silent> <buffer> <leader>t   <Plug>(reason_mode_typeof)
au FileType ocaml,reason nmap <silent> <buffer> <leader>o   <Plug>(reason_mode_occurrences)
au FileType ocaml,reason nmap <silent> <buffer> gd          <Plug>(reason_mode_jump_to_definiton)
```

## Credits

Parts of vim-reason-mode are from other plugins, specifically:

- `ftdetect/reason.vim`, `indent/reason.vim` and `syntax/reason.vim` are from
  `jordwalke/vim-reasonml`

[jordwalke/vim-reasonml]: https://github.com/jordwalke/vim-reasonml
[ALE]: https://github.com/w0rp/ale
