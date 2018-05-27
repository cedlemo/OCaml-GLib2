open Ctypes
open Foreign

(** GLib Doubly Linked List
    https://developer.gnome.org/glib/stable/glib-Doubly-Linked-Lists.html
*)

module type DataTypes = sig
  type t
  val t_typ : t Ctypes.typ
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

  let free =
    foreign "g_list_free" (ptr_opt glist @-> returning void)

  let append dllist element =
    let append_raw =
      foreign "g_list_append" (ptr_opt glist @-> ptr data @-> returning (ptr_opt glist))
    in
    let ptr_element = allocate Data.t_typ element in
    match dllist with
    | Some _ -> append_raw dllist ptr_element
    | None -> let dllist' = append_raw dllist ptr_element in
      let _ = Gc.finalise free dllist' in
      dllist'

  let prepend dllist element =
    let is_start = match dllist with
    | None -> true
    | Some node -> match getf (!@node) glist_prev with
      | None -> true
      | Some _ -> false
    in
    if is_start then begin
      let prepend_raw =
        foreign "g_list_prepend" (ptr_opt glist @-> ptr data @-> returning (ptr_opt glist))
      in
      let ptr_element = allocate Data.t_typ element in
      match dllist with
      | Some _ -> prepend_raw dllist ptr_element
      | None -> let dllist' = prepend_raw dllist ptr_element in
        let _ = Gc.finalise free dllist' in
        dllist'
      end
    else
      raise (Invalid_argument "The element is not the start of the list")

  let remove =
    foreign "g_list_remove" (ptr_opt glist @-> ptr data @-> returning (ptr_opt glist))

  let first =
    foreign "g_list_first" (ptr_opt glist @-> returning (ptr_opt glist))

  let last =
    foreign "g_list_last" (ptr_opt glist @-> returning (ptr_opt glist))

  let length =
    foreign "g_list_length" (ptr_opt glist @-> returning uint)

  let previous = function
    | None -> None
    | Some dllist_ptr ->
        getf (!@dllist_ptr) glist_prev

  let next = function
    | None -> None
    | Some dllist_ptr ->
        getf (!@dllist_ptr) glist_next

  let data = function
    | None -> None
    | Some dllist_ptr ->
        let data_ptr = getf (!@dllist_ptr) glist_data in
        Some (!@data_ptr)
end
