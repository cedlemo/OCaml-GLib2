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
(*
 * https://developer.gnome.org/glib/stable/glib-Hash-Tables.html
 *)
module type DataTypes = sig
  type key
  val key_typ : key Ctypes.typ
  type value
  type value_typ : value Ctypes.typ
  val key_destroy_func : (key ptr -> unit) option
  val value_destroy_func : (value ptr -> unit) option
end

module Make(Data : DataTypes) = struct
  type hash
  let hash : t structure typ = structure "Hash_table"
  let () = seal glist

  module Hash_func = struct
    GCallback.GHashFunc.Make(struct
      type t = hash
      let t_typ = hash
    end)
  end

  module Key_equal_func = struct
    GCallback.GEqualFunc.Make(struct
      type t = hash
      let t_typ = hash
    end)
  end

  let make =
    foreign "g_hash_table_new" (Hash_func.funptr @-> Key_equal_func.funptr @-> returning hash ptr)
end

(*
type t
let t_typ : t structure typ = structure "Hash_table"

let add =
  foreign "g_hash_table_add" (ptr t_typ @-> ptr_opt void @-> returning (bool))
let contains =
  foreign "g_hash_table_contains" (ptr t_typ @-> ptr_opt void @-> returning (bool))
let destroy =
  foreign "g_hash_table_destroy" (ptr t_typ @-> returning (void))
let insert =
  foreign "g_hash_table_insert" (ptr t_typ @-> ptr_opt void @-> ptr_opt void @-> returning (bool))
let lookup =
  foreign "g_hash_table_lookup" (ptr t_typ @-> ptr_opt void @-> returning (ptr_opt void))
let lookup_extended hash_table lookup_key =
  let lookup_extended_raw =
    foreign "g_hash_table_lookup_extended" (ptr t_typ @-> ptr_opt void @-> ptr (ptr_opt void) @-> ptr (ptr_opt void) @-> returning (bool))
  in
  let orig_key_ptr = allocate (ptr_opt void) None in
  let value_ptr = allocate (ptr_opt void) None in
  let ret = lookup_extended_raw hash_table lookup_key orig_key_ptr value_ptr in
  let orig_key = !@ orig_key_ptr in
  let value = !@ value_ptr in
  (ret, orig_key, value)
let remove =
  foreign "g_hash_table_remove" (ptr t_typ @-> ptr_opt void @-> returning (bool))
let remove_all =
  foreign "g_hash_table_remove_all" (ptr t_typ @-> returning (void))
let replace =
  foreign "g_hash_table_replace" (ptr t_typ @-> ptr_opt void @-> ptr_opt void @-> returning (bool))
let size =
  foreign "g_hash_table_size" (ptr t_typ @-> returning (uint32_t))
let steal =
  foreign "g_hash_table_steal" (ptr t_typ @-> ptr_opt void @-> returning (bool))
let steal_all =
  foreign "g_hash_table_steal_all" (ptr t_typ @-> returning (void))
let unref =
  foreign "g_hash_table_unref" (ptr t_typ @-> returning (void))
   *)
