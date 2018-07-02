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
open Test_utils
open OUnit2
open Ctypes
open GLib

module String_hash =
  GLib.Hash_table.Make(struct
    type key = char
    let key = char
    type value = char
    let value = char
  end)

let test_hash_table_create_insert_size test_ctxt =
  let h = String_hash.create Core.int_hash Core.int_equal in
  let france = GLib.Core.string_to_char_ptr "france" in
  let paris = GLib.Core.string_to_char_ptr "paris" in
  let () = String_hash.insert h france paris in
  let allemagne = GLib.Core.string_to_char_ptr "allemagne" in
  let berlin = GLib.Core.string_to_char_ptr "berlin" in
  let () = String_hash.insert h allemagne berlin in
  let s = String_hash.size h in
  let s_ref = Unsigned.UInt.of_int 2 in
  let printer = Unsigned.UInt.to_string in
  assert_equal ~printer s_ref s

let tests =
  "GLib2 Hash_table module tests" >:::
  [
    "Test hash table create/insert/size" >:: test_hash_table_create_insert_size;
  ]

