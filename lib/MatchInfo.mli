open Ctypes

type t
val t_typ : t structure typ
val expand_references:
t structure ptr -> string -> string
val fetch:
t structure ptr -> int32 -> string
(* Not implemented g_match_info_fetch_all return type not handled . *)
val fetch_named:
t structure ptr -> string -> string
(* Not implemented g_match_info_fetch_named_pos argument types not handled . *)
(* Not implemented g_match_info_fetch_pos argument types not handled . *)
val free:
t structure ptr -> unit
val get_match_count:
t structure ptr -> int32
(* Not implemented g_match_info_get_regex return type not handled . *)
val get_string:
t structure ptr -> string
val is_partial_match:
t structure ptr -> bool
val matches:
t structure ptr -> bool
val next:
t structure ptr -> bool
(* Not implemented g_match_info_ref return type not handled . *)
val unref:
t structure ptr -> unit

