(*
 * Copyright 2017 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-GObject-Introspection.
 *
 * OCaml-GObject-Introspection is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-GObject-Introspection is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-GObject-Introspection.  If not, see <http://www.gnu.org/licenses/>.
 *)
open TestUtils
open OUnit2

let test_enum_type_of_value test_ctxt =
  let zero = Unsigned.UInt32.zero in
  let md5 = GLib.Checksum_type.of_value zero in
  assert_equal GLib.Checksum_type.Md5 md5

let test_enum_type_to_value test_ctxt =
  let md5 = GLib.Checksum_type.Md5 in
  let zero = Unsigned.UInt32.zero in
  let value = GLib.Checksum_type.to_value md5 in
  assert_equal zero value

let test_flags_type_list_of_value test_ctxt =
  let open Unsigned.UInt32 in
  let hidden = of_int 1 in
  let in_main = of_int 2 in
  let hidden_and_in_main = logor hidden in_main in
  let flags = GLib.Option_flags.list_of_value hidden_and_in_main in
  let _ = assert_equal_int 2 (List.length flags) in
  let rec check = function
    | [] -> ()
    | h :: q -> let t = (h == GLib.Option_flags.Hidden || h == GLib.Option_flags.In_main) in
    if t == false then let v = GLib.Option_flags.to_value h in
    print_endline (to_string v)
    else let _ = assert_equal_boolean true t in check q
  in
  check flags

let tests =
  "GLib enums tests" >:::
    [
      "Test enum type of value conversion" >:: test_enum_type_of_value;
      "Test enum type to value conversion" >:: test_enum_type_to_value;
      "Test flags type list to value conversion" >:: test_flags_type_list_of_value
    ]

