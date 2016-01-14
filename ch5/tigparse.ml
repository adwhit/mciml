open Core.Std
open Lexer
open Lexing
open Absyn
open Types

let filename = Sys.argv.(1)

let parse fname =
    let inBuffer = open_in fname in
    let lineBuffer = Lexing.from_channel inBuffer in
    try
        let program = Parser.program Lexer.read lineBuffer in
        Format.printf "%s\n" (show_exp program); program
    with
        | Lexer.SyntaxError msg -> Printf.fprintf stderr "%s%!\n" msg; exit 1
        | Parser.Error -> begin
              let curr = lineBuffer.Lexing.lex_curr_p in
              let lineno = curr.Lexing.pos_lnum in
              let colno = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
              let tok = Lexing.lexeme lineBuffer in
              Printf.fprintf stderr "Syntax error at line %d, col %d, token \"%s\"\n" lineno colno tok; exit 1
            end

let () = parse filename; ()

let typeck program symbols = match program with
    | VarExp v -> ()
    | m -> ()

(*
            | NilExp
            | IntExp of int
            | StringExp of string * pos
            | CallExp of symbol * exp list * pos
            | OpExp of exp * oper * exp * pos
            | RecordExp of (symbol * exp * pos) list * symbol * pos
            | SeqExp of (exp * pos) list
            | AssignExp of var * exp * pos
            | IfExp of exp * exp * exp option * pos
            | WhileExp of exp * exp * pos
            | ForExp of symbol * bool ref * exp * exp * exp * pos
            | BreakExp of pos
            | LetExp of dec list * exp * pos
            | ArrayExp of symbol * exp * exp * pos
            [@@deriving show]
*)
