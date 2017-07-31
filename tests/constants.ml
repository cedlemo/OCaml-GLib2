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

let test_boolean_constant test_ctxt =
  assert_equal_boolean false GLib.Core._SOURCE_REMOVE

let test_int8_constant test_ctxt =
  let maxint8 = GLib.Core._MAXINT8 in
  assert_equal ~printer:(fun x -> string_of_int x) 127 maxint8

let tests =
  "GLib constants tests" >:::
  [
    "Test boolean constant" >:: test_boolean_constant;
    "Test int8 constant" >:: test_int8_constant
  ]

