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
  let md5 = GLib.Core.checksumtype_of_value zero in
  assert_equal GLib.Core.Md5 md5

let test_enum_type_to_value test_ctxt =
  let md5 = GLib.Core.Md5 in
  let zero = Unsigned.UInt32.zero in
  let value = GLib.Core.checksumtype_to_value md5 in
  assert_equal zero value

let tests =
  "GLib enums tests" >:::
    [
      "Test enum type of value conversion" >:: test_enum_type_of_value;
      "Test enum type to value conversion" >:: test_enum_type_to_value
    ]

