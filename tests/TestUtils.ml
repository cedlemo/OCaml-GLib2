(*
 * Copyright 2017 Cedric LE MOIGNE, cedlemo@gmx.com
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

open OUnit2

let assert_equal_string str1 str2 =
  assert_equal ~printer: (fun s -> s) str1 str2

let assert_equal_boolean bool1 bool2 =
  assert_equal ~printer: (fun s -> string_of_bool s) bool1 bool2

let assert_equal_int int1 int2 =
  assert_equal ~printer: (fun s -> string_of_int s) int1 int2

let assert_equal_int32 int1 int2 =
  assert_equal ~printer: (fun s -> Int32.to_string s) int1 int2

let assert_equal_or_greater int1 int2 =
    assert_equal ~printer: (fun s ->
        String.concat " " [string_of_int int1;
                           "is not >=";
                           string_of_int int2]) true (int1 >= int2)

let is_travis = try
    bool_of_string (Sys.getenv "TRAVIS_TESTS")
  with
  | _ -> false

let assert_file_exists filename =
  assert_equal_boolean true (Sys.file_exists filename)
