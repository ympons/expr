Nonterminals expression predicate scalar_exp elements element.

Terminals atom var int float string mult_op add_op and_op or_op in_op not_op comp_op '(' ')' ',' true false.

Rootsymbol expression.
Left 100 or_op.
Left 200 and_op.
Left 300 comp_op.
Left 400 in_op.
Left 500 add_op.
Left 600 mult_op.
Nonassoc 700 not_op.

expression -> true : true.
expression -> false : false.
expression -> predicate : '$1'.
expression -> expression or_op expression   : {binary_expr, or_op, '$1', '$3'}.
expression -> expression and_op expression  : {binary_expr, and_op, '$1', '$3'}.
expression -> not_op expression : {unary_expr, not_op, '$2'}.
expression -> '(' expression ')' : '$2'.

predicate -> scalar_exp comp_op scalar_exp : {binary_expr, unwrap2('$2'), '$1', '$3'}.
predicate -> scalar_exp in_op '(' elements ')' : {binary_expr, in_op, '$1', '$4'}.
predicate -> scalar_exp not_op in_op '(' elements ')' : {binary_expr, not_in_op, '$1', '$5'}.

scalar_exp -> scalar_exp add_op scalar_exp : {binary_expr, unwrap2('$2'), '$1', '$3'}.
scalar_exp -> scalar_exp mult_op scalar_exp: {binary_expr, unwrap2('$2'), '$1', '$3'}.
scalar_exp -> element : '$1'.

elements -> element : [unwrap1('$1')].
elements -> element ',' elements : [unwrap1('$1')|'$3'].

element -> atom : '$1'.
element -> var : unwrap2('$1').
element -> int : unwrap2('$1').
element -> string : unwrap2('$1').
element -> float : unwrap2('$1').

Erlang code.

unwrap1({_,V}) -> V.
unwrap2({T,_,V}) -> {T, V}.