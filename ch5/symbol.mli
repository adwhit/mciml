type symbol

val sym : string -> symbol
val name : symbol -> string
val dummy : symbol
val pp_symbol : Format.formatter -> symbol -> unit

type 'a table
val empty : 'a table
val enter : 'a table -> symbol -> 'a -> 'a table
val find : 'a table -> symbol -> 'a option
val showKeys: 'a table -> unit
