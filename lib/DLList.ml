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

(** GLib Doubly Linked List
    https://developer.gnome.org/glib/stable/glib-Doubly-Linked-Lists.html
*)

module type DataTypes = sig
  type t
  val t_typ : t Ctypes.typ
  val free_func : (t ptr -> unit) option
end

module Make(Data : DataTypes) = struct
  type glist
  let glist : glist structure typ = structure "GList"
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

  module GFunc =
    GCallback.GFunc.Make(struct
      type t = data
      let t_typ = data
    end)

  let glist_data = field glist "data" (ptr data)
  let glist_next = field glist "next" (ptr_opt glist)
  let glist_prev = field glist "prev" (ptr_opt glist)
  let () = seal glist

  let free =
    foreign "g_list_free" (ptr_opt glist @-> returning void)

  let free_full =
    foreign "g_list_free_full" (ptr_opt glist @-> GDestroy_notify.funptr @-> returning void)

  let finalise dllist =
    match free_func with
    | None -> Gc.finalise free dllist
    | Some fn ->
      let free_full' sl = free_full sl fn in
      Gc.finalise free_full' dllist

  let append dllist element =
    let append_raw =
      foreign "g_list_append" (ptr_opt glist @-> ptr data @-> returning (ptr_opt glist))
    in
    match dllist with
    | Some _ -> append_raw dllist element
    | None -> let dllist' = append_raw dllist element in
      let () = finalise dllist' in
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
      match dllist with
      | Some _ -> prepend_raw dllist element
      | None -> let dllist' = prepend_raw dllist element in
        let () = finalise dllist' in
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

  let reverse =
    foreign "g_list_reverse" (ptr_opt glist @-> returning (ptr_opt glist))

  let get_previous = function
    | None -> None
    | Some dllist_ptr ->
      getf (!@dllist_ptr) glist_prev

  let get_next = function
    | None -> None
    | Some dllist_ptr ->
      getf (!@dllist_ptr) glist_next

  let get_data = function
    | None -> None
    | Some dllist_ptr ->
      let data_ptr = getf (!@dllist_ptr) glist_data in
      Some data_ptr

  let sort =
    foreign "g_list_sort" (ptr_opt glist @-> Comp_func.funptr @-> returning (ptr_opt glist))

  let nth =
    foreign "g_list_nth" (ptr_opt glist @-> int @-> returning (ptr_opt glist))

  let concat =
    foreign "g_list_concat" (ptr_opt glist @-> ptr_opt glist @-> returning (ptr_opt glist))

  let foreach dllist f =
    let foreign_raw =
      foreign "g_list_foreach" (ptr_opt glist @-> GFunc.funptr @-> returning void)
    in
    (* the following function wrapper is used to ignore the 'gpointer user_data'
     * of the C callback.
     * In C, 'gpointer user_data' are used to pass variables defined in other
     * environment to the callback body.
     * In OCaml a function can be a closure.
     * Closures are functions which carry around some of the "environment" in
     * which they were defined. In particular, a closure can reference variables
     * which were available at the point of its definition.
     * I just have to pass a function that can carry variables from other environment
     * than the callback itself.
     *
     * Ctypes absolutly want the same signature than in C, using f_raw allows
     * user to define the callback to foreach with a signature like
     * ptr data @-> returning void instead of
     * ptr data @-> ptr_opt void @-> returning void.
    *)
    let f_raw a b = f a in
    foreign_raw dllist f_raw
end
