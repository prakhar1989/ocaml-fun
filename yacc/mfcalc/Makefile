all:
	ocamlyacc parser.mly
	ocamlc -c parser.mli
	ocamllex lexer.mll
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c main.ml
	ocamlc -o calc lexer.cmo parser.cmo main.cmo
	rm parser.mli lexer.ml parser.ml
