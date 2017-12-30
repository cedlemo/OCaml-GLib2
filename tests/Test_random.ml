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

open TestUtils
open OUnit2

let test_random_double test_ctxt =
  let rdouble = GLib.Core.random_double () in
  assert_equal ~printer:string_of_bool true (rdouble >= 0.0);
  assert_equal ~printer:string_of_bool true (rdouble <= 1.0)

let tests =
  "Random functions test" >:::
    [
      "test random double" >:: test_random_double
    ]
