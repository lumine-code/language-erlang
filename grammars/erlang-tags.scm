; Each function clause remains a separate navigable definition.
(module_attribute name: (_) @name) @definition.module
(record_decl name: (_) @name) @definition.struct
(record_field name: (_) @name) @definition.field
(pp_define lhs: (macro_lhs name: (_) @name)) @definition.macro
(type_alias name: (type_name name: (_) @name)) @definition.type
(callback fun: (_) @name) @definition.method
(fun_decl clause: (function_clause name: (_) @name)) @definition.function
