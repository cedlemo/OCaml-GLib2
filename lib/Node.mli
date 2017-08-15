open Ctypes

type t
val t_typ : t structure typ
val f_data: (unit ptr, t structure) field
(* TODO Struct field Node : struct tag not implemented . *)
(* TODO Struct field Node : struct tag not implemented . *)
(* TODO Struct field Node : struct tag not implemented . *)
(* TODO Struct field Node : struct tag not implemented . *)
val child_index:
t structure ptr -> unit ptr option -> int32
(* Not implemented g_node_child_position argument types not handled . *)
val depth:
t structure ptr -> Unsigned.uint32
val destroy:
t structure ptr -> unit
(* Not implemented g_node_is_ancestor argument types not handled . *)
val max_height:
t structure ptr -> Unsigned.uint32
val n_children:
t structure ptr -> Unsigned.uint32
val n_nodes:
t structure ptr -> Core.traverseflags_list -> Unsigned.uint32
val reverse_children:
t structure ptr -> unit
val unlink:
t structure ptr -> unit

