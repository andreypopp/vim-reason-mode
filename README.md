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

## Credits

Parts of vim-reason-mode are from other plugins, specifically:

- `ftdetect`, `indent` and `syntax` are from `jordwalke/vim-reasonml`

[jordwalke/vim-reasonml]: https://github.com/jordwalke/vim-reasonml
