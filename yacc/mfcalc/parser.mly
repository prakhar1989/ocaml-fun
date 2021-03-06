%{
open Printf
open Lexing

let var_table = Hashtbl.create 16;;
%}

/* OCamlyacc Declarations */

%token NEWLINE
%token LPAREN RPAREN EQUALS
%token <float> NUM
%token PLUS MINUS MULTIPLY DIVIDE CARET
%token <string> VAR
%token <float->float> FUNCTION


%left PLUS MINUS
%left MULTIPLY DIVIDE
%left NEG 
%right CARET

%start input
%type <unit> input

%%

/* grammer follows */

input:
    | /* empty */ { }
    | input line  { }
;

line: 
    | NEWLINE { }
    | exp NEWLINE { printf "\t = %.10g\n" $1; flush stdout }
    | error NEWLINE { }
;

exp: 
    | NUM                        { $1 }
    | VAR                        {
        try Hashtbl.find var_table $1
        with Not_found ->
            printf "no such variable `%s`\n" $1;
            0.0
    }
    | VAR EQUALS exp             {
        Hashtbl.replace var_table  $1 $3;
        $3
    }
    | FUNCTION LPAREN exp RPAREN { $1 $3 }
    | exp PLUS exp               { $1 +. $3 }
    | exp MINUS exp              { $1 -. $3 }
    | exp MULTIPLY exp           { $1 *. $3 }
    | exp DIVIDE exp             { $1 /. $3 }
    | MINUS exp %prec NEG        { -. $2 }
    | exp CARET exp              { $1 ** $3 }
    | LPAREN exp RPAREN          { $2 }
;


