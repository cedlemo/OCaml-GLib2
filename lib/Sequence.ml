(*
 * Copyright 2020 Cedric LE MOIGNE, cedlemo@gmx.com
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

(**
  GLib GSequence bindings
   https://developer.gnome.org/glib/stable/glib-Sequences.html#GSequence
*)

module type DataTypes = sig
  type t
  val t_typ : t Ctypes.typ
end

module Make(Data : DataTypes) = struct
  type sequence = unit ptr
  let sequence : sequence typ = ptr void
  type data = Data.t
  let data = Data.t_typ

  module GDestroy_notify =
    GCallback.GDestroyNotify.Make(struct
      type t = data
      let t_typ = data
    end)

  let create =
    foreign "g_sequence_new" (GDestroy_notify.funptr @-> returning sequence)

  let free =
    foreign "g_sequence_free" (sequence @-> returning void)

  let length =
    foreign "g_sequence_get_length" (sequence @-> returning uint)

  let empty =
    foreign "g_sequence_is_empty" (sequence @-> returning bool)
end
