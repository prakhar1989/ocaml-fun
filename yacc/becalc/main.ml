let parse_string str =
  let lb = Lexing.from_string str in
  Parser.expr Lexer.token lb
;;

let token_list_of_string s =
  let lb = Lexing.from_string s in
  let rec helper l =
    let t = Lexer.token lb in
    if t = Parser.EOF then List.rev l else helper (t::l)
  in 
  helper []
;;

let testcases : (string * Parser.token list) list = [
  ("true || false", [Parser.TRUE;  Parser.OR; Parser.FALSE]);
  ("false || true", [Parser.FALSE; Parser.OR; Parser.TRUE ]);
  ("true && false", [Parser.TRUE; Parser.AND; Parser.FALSE]);
  ("(false)"      , [Parser.LEFTPAREN; Parser.TRUE; Parser.RIGHTPAREN])
];;

List.iter (fun (s, p) -> 
    let t = token_list_of_string s in 
    assert(p = t)
  ) testcases
;;

