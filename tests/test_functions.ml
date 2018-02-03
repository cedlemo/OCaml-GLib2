(*
 * Copyright 2017-2018 Cedric LE MOIGNE, cedlemo@gmx.com
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

let test_glib_check_version test_ctxt =
  let open Unsigned.UInt32 in
    let major = of_int32 GLib.Core.c_MAJOR_VERSION in
    let minor = of_int32 GLib.Core.c_MINOR_VERSION in
    let micro = of_int32 GLib.Core.c_MICRO_VERSION in
    match GLib.Core.check_version major minor micro with
    | None -> assert_equal_string "Ok" "Ok"
    | Some version_mismatch -> assert_equal_string "version mismatch" version_mismatch

let test_filename_to_uri_ok test_ctxt =
  let path ="/var" in
  match GLib.Core.filename_to_uri path None with
  | Error e -> assert_equal_string "This should not " "have been reached"
  | Ok uri -> match uri with
    | None -> assert_equal_string "This should not " "have been reached"
    | Some uri' -> assert_equal_string "file:///var" uri'

let test_filename_from_uri_no_hostname test_ctxt =
  let uri = "file:///etc/mpd.conf" in
  match GLib.Core.filename_from_uri uri with
  | Error e -> assert_equal_string "GError: This should not " "have been reached"
  | Ok (filename, hostname_opt) ->
      let _ = assert_equal_string "/etc/mpd.conf" filename in
      match hostname_opt with
      | None -> assert true
      | Some h -> assert_equal_string "This should not " "have been reached"

let test_filename_from_uri_bad_uri test_ctxt =
  let uri = "noprotocoletc/mpd.conf" in
  match GLib.Core.filename_from_uri uri with
  | Error e -> assert true
  | Ok _ -> assert_equal_string "This should not " "have been reached"

let test_filename_from_uri_with_hostname test_ctxt =
  let uri = "file://localhost/etc/mpd.conf" in
  match GLib.Core.filename_from_uri uri with
  | Error e -> assert_equal_string "GError: This should not " "have been reached"
  | Ok (filename, hostname_opt) ->
      let _ = assert_equal_string "/etc/mpd.conf" filename in
      match hostname_opt with
      | None -> assert_equal_string "This should not " "have been reached"
      | Some h -> assert_equal_string "localhost" h

let test_get_charset_ok test_ctxt =
  let (is_utf8, charset) = GLib.Core.get_charset () in
  if is_utf8 then
    assert_equal_string "UTF-8" charset
  else
    assert ("UTF-8" <> charset)

let test_filename_to_uri_error test_ctxt =
  let path ="a_totally_bad_path_that_should_not_exist" in
  let expected = "The pathname a_totally_bad_path_that_should_not_exist is \
                  not an absolute path" in
  let filter_meaningless_char str =
    String.split_on_char '\'' str
    |> String.concat ""
    |> Str.(split (regexp "\(“\|”\)"))
    |> String.concat ""
  in
  let _ = match GLib.Core.filename_to_uri path None with
  | Error e -> (
       match e with
       | None -> assert_equal_string "This should not " "have been reached"
       | Some err ->
           let error_message = Ctypes.(getf (!@ err) GLib.Error.f_message) in
           assert_equal_string  expected (filter_meaningless_char error_message);
           assert_equal_int32 (Int32.of_int 5) Ctypes.(getf (!@ err) GLib.Error.f_code)
  )
  | Ok uri -> assert_equal_string "This should not " "have been reached"
  in at_exit Gc.full_major

let test_dir_make_tmp test_ctxt =
  match GLib.Core.dir_make_tmp None with
  | Error _ -> assert_equal_string "Error with dir_make_tmp " "this should not have been reached"
  | Ok tmp_opt -> match tmp_opt with
      | None -> assert_equal_string "no tmp " "this should not have been reached"
      | Some tmp -> assert_file_exists tmp

let tests =
  "GLib functions tests" >:::
    [
      "Test glib check version" >:: test_glib_check_version;
      "Test glib filename_to_uri ok" >:: test_filename_to_uri_ok;
      "Test glib filename_to_uri with error" >:: test_filename_to_uri_error;
      "Test glib get_charset ok" >:: test_get_charset_ok;
      "Test glib dir_make_tmp" >:: test_dir_make_tmp;
      "Test glib filename from uri no hostname" >:: test_filename_from_uri_no_hostname;
      "Test glib filename from uri bad uri" >:: test_filename_from_uri_bad_uri;
      "Test glib filename from uri with hostname" >:: test_filename_from_uri_with_hostname;
    ]
