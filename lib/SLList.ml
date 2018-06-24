open Ctypes
open Foreign
(** GLib Singly Linked List
 * https://developer.gnome.org/glib/stable/glib-Singly-Linked-Lists.html
*)

module type DataTypes = sig
  type t
  val t_typ : t Ctypes.typ
end

module Make(Data : DataTypes) = struct
  type slist
  let slist : slist structure typ = structure "SList"
  type data = Data.t
  let data = Data.t_typ

  module Comp_func =
    GCallback.CompareFunc.Make(struct
      type t = data
      let t_typ = data
    end)

  let slist_data  = field slist "data" (ptr data)
  let slist_next  = field slist "next" (ptr_opt slist)
  let () = seal slist

  let free =
    foreign "g_slist_free" (ptr_opt slist @-> returning void)

  let append sllist element =
    let append_raw =
      foreign "g_slist_append" (ptr_opt slist @-> ptr data @-> returning (ptr_opt slist))
    in
    match sllist with
    | Some _ -> append_raw sllist element
    | None -> let sllist' = append_raw sllist element in
      let _ = Gc.finalise free sllist' in
      sllist'

  let prepend sllist element =
    let is_start = match sllist with
      | None -> true
      | Some _ -> false
    in
    if is_start then begin
      let prepend_raw =
        foreign "g_slist_prepend" (ptr_opt slist @-> ptr data @-> returning (ptr_opt slist))
      in
      match sllist with
      | Some _ -> prepend_raw sllist element
      | None -> let sllist' = prepend_raw sllist element in
        let _ = Gc.finalise free sllist' in
        sllist'
    end
    else
      raise (Invalid_argument "The element is not the start of the list")

  let length =
    foreign "g_slist_length" (ptr_opt slist @-> returning uint)

  let next = function
    | None -> None
    | Some sllist_ptr ->
      getf (!@sllist_ptr) slist_next

  let data = function
    | None -> None
    | Some sllist_ptr ->
      let data_ptr = getf (!@sllist_ptr) slist_data in
      Some (!@data_ptr)

  let data_ptr = function
    | None -> None
    | Some sllist_ptr ->
      let data_ptr = getf (!@sllist_ptr) slist_data in
      Some data_ptr

  let last =
    foreign "g_slist_last" (ptr_opt slist @-> returning (ptr_opt slist))

  let sort sllist =
    let sort_raw =
      foreign "g_slist_sort" (ptr_opt slist @-> Comp_func.funptr @-> returning (ptr_opt slist))
    in
    sort_raw sllist
end
