open Ctypes
open Foreign

(** type t
let t_typ : t structure typ = structure "List"

let f_data = field t_typ "data" (ptr void)
let f_next = field t_typ "next" (ptr t_typ)
let f_prev = field t_typ "prev" (ptr t_typ)
let _ = seal t_typ
**)

(** GList struct
type glist
let glist : glist structure typ = structure "GList"
let glist_data  = field glist "data" (ptr void)
let glist_next  = field glist "next" (ptr_opt glist)
let glist_prev  = field glist "prev" (ptr_opt glist)
let () = seal glist

let g_free =
  foreign "g_free"
    (ptr void @-> returning void)

let g_free_t = ptr void @-> returning void

let glist_free_full =
  foreign "g_list_free_full"
    (ptr glist @-> funptr g_free_t @-> returning void)

(** Get the next element of a glist *)
let g_list_next l_ptr =
  getf (!@l_ptr) glist_next

(** Get the void ptr data of the current element *)
let g_list_data l_ptr =
  getf (!@l_ptr) glist_data

(** Transform a GList of strings to an OCaml list of strings *)
let glist_of_strings_to_list glist_ptr =
  let rec loop acc p =
    match p with
    | None -> List.rev acc
    | Some p' -> let data = g_list_data p' in
      let next = g_list_next p' in
      match coerce (ptr void) string_opt data with
      | None -> loop acc next
      | Some s -> loop (s :: acc) next
  in
  let ocaml_list = loop [] (Some glist_ptr) in
  let _ = glist_free_full glist_ptr g_free in
  ocaml_list
**)

module type DataTypes = sig
  type t
  val t_typ : string Ctypes.typ
end

module Make(Data : DataTypes) = struct
  type glist
  let glist : glist structure typ = structure "GList"
  type data = Data.t
  let data = Data.t_typ

  let glist_data  = field glist "data" (ptr data)
  let glist_next  = field glist "next" (ptr_opt glist)
  let glist_prev  = field glist "prev" (ptr_opt glist)
  let () = seal glist
end
