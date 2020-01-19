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
open Test_utils
open OUnit2
open Ctypes
open GLib

module String_sequence =
  GLib.Sequence.Make(struct
    type t = char
    let t_typ = char
  end)

(* let build_empty_sequence_sample () =
  let s = String_sequence.create None in
  let france = GLib.Core.string_to_char_ptr "france" in
  let paris = GLib.Core.string_to_char_ptr "paris" in
  let () = String_hash.insert h france paris in
  let allemagne = GLib.Core.string_to_char_ptr "allemagne" in
  let berlin = GLib.Core.string_to_char_ptr "berlin" in
  let () = String_hash.insert h allemagne berlin in
  h
*)

let test_empty_sequence test_ctxt =
  let s = String_sequence.create (fun _ -> ()) in
  let len = String_sequence.length s in
  let () = assert_equal_uint (Unsigned.UInt.zero) len in
  let is_empty = String_sequence.is_empty s in
  assert_equal_boolean true is_empty

let tests =
  "GLib2 sequence module tests" >:::
  [
    "Test empty sequence" >:: test_empty_sequence;
  ]
