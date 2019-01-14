# vim-reason-mode

vim-reason-mode is another vim mode for Reason/OCaml, uses merlin under the
hood.

## Installation

I use [vim-plug][] and recomment it unless you settled on other option.

Minimal installation:

    Plug 'andreypopp/vim-reason-mode'

Complete installation:

    Plug 'junegunn/fzf'              " needed for :ReasonModeModuleOutline
    Plug 'junegunn/fzf.vim'

    Plug 'w0rp/ale'                  " needed for diagnostics

    Plug 'lifepillar/vim-mucomplete' " needed for autocomplete

    Plug 'andreypopp/vim-reason-mode'

[vim-plug]: https://github.com/junegunn/vim-plug

## Credits

Parts of vim-reason-mode are from other plugins, specifically:

- `ftdetect`, `indent` and `syntax` are from `jordwalke/vim-reasonml`
