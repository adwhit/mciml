open Symbol

type pos = Lexing.position

let pp_pos fmt pos = ()
(* skip pretty-printing of position for now *)

type var = SimpleVar of symbol * pos
         | FieldVar of var * symbol * pos
         | SubscriptVar of var * exp * pos
         [@@deriving show]

and exp = VarExp of var
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

and dec = FunctionDec of fundec
        | VarDec of vardec
        | TypeDec of (symbol * ty * pos)
        [@@deriving show]

and ty = NameTy of symbol * pos
       | RecordTy of field list
       | ArrayTy of symbol * pos
       [@@deriving show]

and oper = PlusOp | MinusOp | TimesOp | DivideOp
         | EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp
         [@@deriving show]

and field = {name: symbol; escape: bool ref; typ: symbol; pos: pos}
            [@@deriving show]

and fundec = {name: symbol; params: field list;
		      result: (symbol * pos) option;
		      body: exp; pos: pos}
             [@@deriving show]

and vardec = {name: symbol;
              escape: bool ref;
              typ: (symbol * pos) option;
              init: exp;
              pos: pos}
             [@@deriving show]
