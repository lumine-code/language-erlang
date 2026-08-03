# language-erlang

Erlang language support.

## Features

- **Grammars**: provides Tree-sitter grammars, built from [tree-sitter-erlang](https://github.com/WhatsApp/tree-sitter-erlang).
- **Syntax highlighting**: full tree-sitter grammar coverage for Erlang files.
- **Folding**: folds blocks from the parse tree rather than by indentation.

## Installation

To install `language-erlang` search for _language-erlang_ in the Install pane of the Lumine settings or run `lumine --install lumine-code/language-erlang`.

## Services

- **hyperlink.injection** (`^1.0.0`): consumed to highlight URLs inside Erlang files as clickable links.
- **todo.injection** (`^1.0.0`): consumed to highlight `TODO`-style markers inside comments.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
