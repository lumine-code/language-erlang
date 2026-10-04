# language-erlang

Erlang language support.

## Features

- **Grammars**: provides Tree-sitter grammars, built from [tree-sitter-erlang](https://github.com/WhatsApp/tree-sitter-erlang).
- **Symbols**: modules, function clauses, records, macros, types and callbacks.
- **Syntax highlighting**: full tree-sitter grammar coverage for Erlang files.
- **Folding**: folds blocks from the parse tree rather than by indentation.

## Installation

To install `language-erlang` search for it in the Install pane of the Lumine settings, or run the command `lumine --install lumine-code/language-erlang`.

## Injections

- Static Tree-sitter injections highlight URLs with `language-hyperlink`.
- Static Tree-sitter injections highlight comment markers with `language-todo`.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
