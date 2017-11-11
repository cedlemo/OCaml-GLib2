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

let test_ascii_strup test_ctxt =
  let upcase = GLib.Core.ascii_strup "up_case" (Int64.of_int (-1)) in
  assert_equal_string "UP_CASE" upcase;
  let upcase = GLib.Core.ascii_strup "up_case" (Int64.of_int 3) in
  assert_equal_string "UP_" upcase

let test_filename_to_uri_ok test_ctxt =
  let path ="/var" in
  match GLib.Core.filename_to_uri path None with
  | Error e -> assert_equal_string "This should not " "have been reached"
  | Ok uri -> match uri with
    | None -> assert_equal_string "This should not " "have been reached"
    | Some uri' -> assert_equal_string "file:///var" uri'

let test_filename_to_uri_error test_ctxt =
  let path ="a_totally_bad_path_that_should_not_exist" in
  let expected = "The pathname “a_totally_bad_path_that_should_not_exist” is \
                  not an absolute path" in
  let _ = match GLib.Core.filename_to_uri path None with
  | Error e -> (
       match e with
               | None -> assert_equal_string "This should not " "have been reached"
               | Some err ->
                   assert_equal_string  expected Ctypes.(getf (!@ err) GLib.Error.f_message);
                   assert_equal_int32 (Int32.of_int 5) Ctypes.(getf (!@ err) GLib.Error.f_code)
  )
  | Ok uri -> assert_equal_string "This should not " "have been reached"
  in at_exit Gc.full_major

let tests =
  "GLib functions tests" >:::
    [
      "Test glib check version" >:: test_glib_check_version;
      "Test glib ascii_strdown full length" >:: test_ascii_strdown_full;
      "Test glib ascii_strdown partial length" >:: test_ascii_strdown_partial;
      "Test glib ascii_strcasecmp" >:: test_ascii_strcasecmp;
      "Test glib ascii_strcasencmp" >:: test_ascii_strncasecmp;
      "Test glib ascii_strup" >:: test_ascii_strup;
      "Test glib filename_to_uri ok" >:: test_filename_to_uri_ok;
      "Test glib filename_to_uri with error" >:: test_filename_to_uri_error
    ]
