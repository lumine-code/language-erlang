;; Copyright (c) Facebook, Inc. and its affiliates.
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;     http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.
;; ---------------------------------------------------------------------

;; Based initially on the contents of https://github.com/WhatsApp/tree-sitter-erlang/issues/2 by @Wilfred
;; and https://github.com/the-mikedavis/tree-sitter-erlang/blob/main/queries/highlights.scm
;;
;; The tests are also based on those in
;; https://github.com/the-mikedavis/tree-sitter-erlang/tree/main/test/highlight
;;

;; Last match wins in this file.
;; As of https://github.com/tree-sitter/tree-sitter/blob/master/CHANGELOG.md#breaking-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Primitive types
(string) @string.quoted.double.erlang
(char) @constant.other.erlang
(integer) @constant.numeric.erlang
(var) @variable.other.erlang
(atom) @constant.other.symbol.erlang

;;; Comments
((var) @comment.line.discard.erlang
 (#match? @comment.line.discard.erlang "^_"))

(dotdotdot) @comment.line.discard.erlang
(comment) @comment.line.erlang

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
(fa fun: (atom) @entity.name.function.erlang)
(type_name name: (atom) @entity.name.function.erlang)
(call expr: (atom) @entity.name.function.erlang)
(function_clause name: (atom) @entity.name.function.erlang)
(internal_fun fun: (atom) @entity.name.function.erlang)

;; This is a fudge, we should check that the operator is '/'
;; But our grammar does not (currently) provide it
(binary_op_expr lhs: (atom) @entity.name.function.erlang rhs: (integer))

;; Others
(remote_module module: (atom) @entity.name.namespace.erlang)
(remote fun: (atom) @entity.name.function.erlang)
(macro_call_expr name: (var) @constant.other.erlang)
(macro_call_expr name: (var) @keyword.control.directive.erlang args: (_) )
(macro_call_expr name: (atom) @keyword.control.directive.erlang)
(record_field_name name: (atom) @variable.other.member.erlang)
(record_name name: (atom) @support.type.erlang)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Attributes

;; module attribute
(module_attribute
  name: (atom) @entity.name.namespace.erlang)

;; behaviour
(behaviour_attribute name: (atom) @entity.name.namespace.erlang)

;; export

;; Import attribute
(import_attribute
    module: (atom) @entity.name.namespace.erlang)

;; export_type

;; optional_callbacks

;; compile
(compile_options_attribute
    options: (tuple
      expr: (atom)
      expr: (list
        exprs: (binary_op_expr
          lhs: (atom)
          rhs: (integer)))))

;; file attribute

;; record
(record_decl name: (atom) @support.type.erlang)
(record_decl name: (macro_call_expr name: (var) @constant.other.erlang))
(record_field name: (atom) @variable.other.member.erlang)

;; type alias

;; opaque

;; Spec attribute
(spec fun: (atom) @entity.name.function.erlang)
(spec
  module: (module name: (atom) @entity.name.namespace.erlang)
  fun: (atom) @entity.name.function.erlang)

;; callback
(callback fun: (atom) @entity.name.function.erlang)

;; wild attribute
(wild_attribute name: (attr_name name: (atom) @keyword.control.erlang))

;; fun decl

;; include/include_lib

;; ifdef/ifndef
(pp_ifdef name: (_) @keyword.control.directive.erlang)
(pp_ifndef name: (_) @keyword.control.directive.erlang)

;; define
(pp_define
    lhs: (macro_lhs
      name: (var) @constant.other.erlang))
(pp_define
    lhs: (macro_lhs
      name: (_) @keyword.control.directive.erlang
      args: (var_args args: (var))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reserved words
[ "after"
  "and"
  "band"
  "begin"
  "behavior"
  "behaviour"
  "bnot"
  "bor"
  "bsl"
  "bsr"
  "bxor"
  "callback"
  "case"
  "catch"
  "compile"
  "define"
  "div"
  "elif"
  "else"
  "end"
  "endif"
  "export"
  "export_type"
  "file"
  "fun"
  "if"
  "ifdef"
  "ifndef"
  "import"
  "include"
  "include_lib"
  "module"
  "of"
  "opaque"
  "optional_callbacks"
  "or"
  "receive"
  "record"
  "spec"
  "try"
  "type"
  "undef"
  "unit"
  "when"
  "xor"] @keyword.control.erlang

["andalso" "orelse"] @keyword.operator.word.erlang

;; Punctuation
"," @punctuation.separator.comma.erlang
"." @punctuation.terminator.clause.erlang
";" @punctuation.separator.clause.erlang
"(" @punctuation.definition.arguments.begin.bracket.round.erlang
")" @punctuation.definition.arguments.end.bracket.round.erlang
"{" @punctuation.definition.tuple.begin.bracket.curly.erlang
"}" @punctuation.definition.tuple.end.bracket.curly.erlang
"[" @punctuation.definition.list.begin.bracket.square.erlang
"]" @punctuation.definition.list.end.bracket.square.erlang

; `<< >>` delimits a binary.
"<<" @punctuation.definition.binary.begin.erlang
">>" @punctuation.definition.binary.end.erlang

;; Operators
["!"
 "->"
 "<-"
 "#"
 "::"
 ":>"
 "|"
 ":"
 "="
 "||"

 "+"
 "-"
 "bnot"
 "not"

 "/"
 "*"
 "div"
 "rem"
 "band"
 "and"

 "+"
 "-"
 "bor"
 "bxor"
 "bsl"
 "bsr"
 "or"
 "xor"

 "++"
 "--"

 "=="
 "/="
 "=<"
 "<"
 ">="
 ">"
 "=:="
 "=/="
 ] @keyword.operator.erlang
