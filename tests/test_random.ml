(*
 * Copyright 20172018 Cedric LE MOIGNE, cedlemo@gmx.com
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

let test_random_double test_ctxt =
  let rdouble = GLib.Core.random_double () in
  assert_equal ~printer:string_of_bool true (rdouble >= 0.0);
  assert_equal ~printer:string_of_bool true (rdouble <= 1.0)

let test_random_double_range test_ctxt =
  let start = 5.0 in
  let stop = 6.0 in
  let rdouble = GLib.Core.random_double_range start stop in
  assert_equal ~printer:string_of_bool true (rdouble >= start);
  assert_equal ~printer:string_of_bool true (rdouble <= stop)

let test_random_int test_ctxt =
  let open Unsigned in
  let rint = GLib.Core.random_int () in
  assert_equal ~printer:string_of_bool true UInt32.((compare rint zero) >= 0);
  assert_equal ~printer:string_of_bool true UInt32.((compare rint GLib.Core.c_MAXUINT32) <= 0)

let test_random_int_range test_ctxt =
  let open Unsigned in
  let start = Int32.of_int 10 in
  let stop = Int32.of_int 21 in
  let rint = GLib.Core.random_int_range start stop in
  assert_equal ~printer:string_of_bool true Int32.((compare rint start) >= 0);
  assert_equal ~printer:string_of_bool true Int32.((compare rint stop) <= 0)


let tests =
  "Random functions test" >:::
    [
      "test random double" >:: test_random_double;
      "test random double range" >:: test_random_double_range;
      "test random int" >:: test_random_int;
      "test random int range" >:: test_random_int_range;
    ]
