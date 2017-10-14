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

let test_glib_check_version test_ctxt =
  let open Unsigned.UInt32 in
  let major = of_int 2 in
  let minor = of_int 52 in
  let micro = of_int 3 in
  let _ = (
    match GLib.Core.check_version major minor micro with
    | None -> assert_equal_string "Ok" "Ok"
    | Some version_mismatch -> assert_equal_string "version mismatch" version_mismatch
  )
  in
  let major = of_int 3 in
  let minor = of_int 52 in
  let micro = of_int 3 in
  match GLib.Core.check_version major minor micro with
    | None -> assert_equal_string "Ok" "Ok"
    | Some version_mismatch -> assert_equal_string "GLib version too old (major mismatch)" version_mismatch


let tests =
  "GLib functionss tests" >:::
    [
      "Test glib check version" >:: test_glib_check_version
    ]
