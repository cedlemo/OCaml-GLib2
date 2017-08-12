open Ctypes

type t
val t_typ : t structure typ
val join:
t structure ptr -> unit ptr option
(* Not implemented g_thread_ref return type not handled . *)
val unref:
t structure ptr -> unit
val error_quark:
t structure ptr -> Unsigned.uint32
val exit:
t structure ptr -> unit ptr option -> unit
(* Not implemented g_thread_self return type not handled . *)
val yield:
t structure ptr -> unit

