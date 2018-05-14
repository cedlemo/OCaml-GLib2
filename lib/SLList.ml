open Ctypes
open Foreign
(** GLib Singly Linked List
 * https://developer.gnome.org/glib/stable/glib-Singly-Linked-Lists.html
*)

module type DataTypes = sig
  type t
  type ctype
  val t_typ : ctype Ctypes.typ
end
module Make(Data : DataTypes) = struct
  type slist
  let slist : slist structure typ = structure "SList"
  type data = Data.t
  let data = Data.t_typ

  let glist_data  = field slist "data" (ptr data)
  let glist_next  = field slist "next" (ptr_opt slist)
  let () = seal slist
end
