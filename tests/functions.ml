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
    let major = of_int32 GLib.Core.c_MAJOR_VERSION in
    let minor = of_int32 GLib.Core.c_MINOR_VERSION in
    let micro = of_int32 GLib.Core.c_MICRO_VERSION in
    match GLib.Core.check_version major minor micro with
    | None -> assert_equal_string "Ok" "Ok"
    | Some version_mismatch -> assert_equal_string "version mismatch" version_mismatch

let test_ascii_strdown_full test_ctxt =
  let lowcase = GLib.Core.ascii_strdown "LOW_CASE" (Int64.of_int (-1)) in
  assert_equal_string "low_case" lowcase

let test_ascii_strdown_partial test_ctxt =
  let lowcase = GLib.Core.ascii_strdown "LOW_CASE" (Int64.of_int 3) in
  assert_equal_string "low" lowcase

let test_ascii_strcasecmp test_ctxt =
  let open Int32 in
  assert_equal_int32 zero (GLib.Core.ascii_strcasecmp "Hi, Hallo" "Hi, Hallo");
  assert_equal_int32 zero (GLib.Core.ascii_strcasecmp "hi, hALLO" "Hi, Hallo")

let test_ascii_strncasecmp test_ctxt =
  let open Int32 in
  assert_equal_int32 zero (GLib.Core.ascii_strncasecmp "Hi, Hallo" "Hi, Hallo" (Unsigned.UInt64.of_int 8));
  assert_equal_int32 zero (GLib.Core.ascii_strncasecmp "hi, hALLO" "Hi, Hallo" (Unsigned.UInt64.of_int 8));
  assert_equal_int32 zero (GLib.Core.ascii_strncasecmp "hi, hALLO" "Hi, Hatoto" (Unsigned.UInt64.of_int 5))

let tests =
  "GLib functionss tests" >:::
    [
      "Test glib check version" >:: test_glib_check_version;
      "Test glib ascii_strdown full length" >:: test_ascii_strdown_full;
      "Test glib ascii_strdown partial length" >:: test_ascii_strdown_partial;
      "Test glib ascii_strcasecmp" >:: test_ascii_strcasecmp;
      "Test glib ascii_strcasencmp" >:: test_ascii_strncasecmp
    ]
