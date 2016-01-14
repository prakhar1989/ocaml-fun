(* local defs - lexical scoping *)
let f x = x + 1 in
let g y = f (f y) in 
let f x = 2 * x in
g 5;;

(* global definitions - dynamic scoping *)
let f x = x + 1;;
let g y = f (f y);;
let f x = 2 * x;;
g 5;; 
