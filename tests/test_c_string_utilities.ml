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

let test_strlen test_ctxt =
  let str = "abcd" in
  let len = String.length str in
  let char_ptr = GLib.Core.string_to_char_ptr str in
  let len' = GLib.Core.str_len char_ptr in
  assert_equal_int len' len

let test_OCaml_C_string_converters test_ctxt =
  let str = "abcd" in
  let char_ptr = GLib.Core.string_to_char_ptr str in
  let str' = GLib.Core.char_ptr_to_string char_ptr in
  assert_equal_string str str'

let tests =
  "GLib Core C strings utilities" >:::
  [
    "Test strlen" >:: test_strlen;
    "Test OCaml C string converters" >:: test_OCaml_C_string_converters;
  ]

