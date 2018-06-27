(*
 * Copyright 2018 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-GLib2.
 *
 * OCaml-GLib2 is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-GLib2 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-GLib2.  If not, see <http://www.gnu.org/licenses/>.
 *)

open Ctypes
open Foreign
(** GLib Singly Linked List
 * https://developer.gnome.org/glib/stable/glib-Singly-Linked-Lists.html
*)

module type DataTypes = sig
  type t
  val t_typ : t Ctypes.typ
  val free_func : (t ptr -> unit) option
end

module Make(Data : DataTypes) = struct
  type slist
  let slist : slist structure typ = structure "SList"
  type data = Data.t
  let data = Data.t_typ
  let free_func = Data.free_func

  module Comp_func =
    GCallback.CompareFunc.Make(struct
      type t = data
      let t_typ = data
    end)

  module GDestroy_notify =
    GCallback.GDestroyNotify.Make(struct
      type t = data
      let t_typ = data
    end)

  let slist_data  = field slist "data" (ptr data)
  let slist_next  = field slist "next" (ptr_opt slist)
  let () = seal slist

  let free =
    foreign "g_slist_free" (ptr_opt slist @-> returning void)

  let free_full =
      foreign "g_slist_free_full" (ptr_opt slist @-> GDestroy_notify.funptr @-> returning void)

  let finalise sllist =
    match free_func with
    | None -> Gc.finalise free sllist
    | Some fn ->
      let free_full' sl = free_full sl fn in
      Gc.finalise free_full' sllist

  let append sllist element =
    let append_raw =
      foreign "g_slist_append" (ptr_opt slist @-> ptr data @-> returning (ptr_opt slist))
    in
    match sllist with
    | Some _ -> append_raw sllist element
    | None -> let sllist' = append_raw sllist element in
      let () = finalise sllist' in
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
        let () = finalise sllist' in
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

  let get_data = function
    | None -> None
    | Some sllist_ptr ->
      let data_ptr = getf (!@sllist_ptr) slist_data in
      Some data_ptr

  let last =
    foreign "g_slist_last" (ptr_opt slist @-> returning (ptr_opt slist))

  let sort =
    foreign "g_slist_sort" (ptr_opt slist @-> Comp_func.funptr @-> returning (ptr_opt slist))

  let nth =
    foreign "g_slist_nth" (ptr_opt slist @-> int @-> returning (ptr_opt slist))

  let concat =
    foreign "g_slist_concat" (ptr_opt slist @-> ptr_opt slist @-> returning (ptr_opt slist))
end
