% Assertions live in the comments: `<- scope` checks the marker's own column
% on the previous non-comment line, `^ scope` checks the caret's. Scopes
% match by prefix, so the trailing `.erlang` segment is left off.

-module(demo).
%      ^ punctuation.definition.arguments.begin.bracket.round
%            ^ punctuation.terminator.clause

go(N) -> {ok, N}.
%        ^ punctuation.definition.tuple.begin.bracket.curly
%           ^ punctuation.separator.comma

% a comment
% <- comment
