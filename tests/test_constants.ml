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

let test_boolean_constant test_ctxt =
  assert_equal_boolean false GLib.Core.c_SOURCE_REMOVE

let test_int8_constant test_ctxt =
  let maxint8 = GLib.Core.c_MAXINT8 in
  assert_equal ~printer:(fun x -> string_of_int x) 127 maxint8

let test_uint8_constant test_ctxt =
  let maxuint8 = GLib.Core.c_MAXUINT8 in
  assert_equal ~printer:(fun x -> Unsigned.UInt8.to_string x)
               (Unsigned.UInt8.of_int 255) maxuint8

let test_int16_constant test_ctxt =
  let maxint16 = GLib.Core.c_MAXINT16 in
  assert_equal ~printer:(fun x -> string_of_int x) 32767 maxint16

let test_uint16_constant test_ctxt =
  let maxuint16 = GLib.Core.c_MAXUINT16 in
  assert_equal ~printer:(fun x -> Unsigned.UInt16.to_string x)
               (Unsigned.UInt16.of_int 65535) maxuint16

let test_int32_constant test_ctxt =
  let maxint32 = GLib.Core.c_MAXINT32 in
  assert_equal ~printer:(fun x -> Int32.to_string x)
               (Int32.of_string "2147483647") maxint32

let test_uint32_constant test_ctxt =
  let maxuint32 = GLib.Core.c_MAXUINT32 in
  assert_equal ~printer:(fun x -> Unsigned.UInt32.to_string x)
               (Unsigned.UInt32.of_string "4294967295") maxuint32

let test_int64_constant test_ctxt =
  let maxint64 = GLib.Core.c_MAXINT64 in
  assert_equal ~printer:(fun x -> Int64.to_string x)
               9223372036854775807L maxint64

let test_uint64_constant test_ctxt =
  let maxuint64 = GLib.Core.c_MAXUINT64 in
  assert_equal ~printer:(fun x -> Unsigned.UInt64.to_string x)
               (Unsigned.UInt64.of_string "18446744073709551615") maxuint64

let test_double_constant test_ctxt =
  let e = GLib.Core.c_E in
  assert_equal ~printer:(fun x -> string_of_float x)
               2.718282 e

let test_string_constant test_ctxt =
  let cset_a_2_z = GLib.Core.c_CSET_A_2_Z in
  assert_equal "ABCDEFGHIJKLMNOPQRSTUVWXYZ" cset_a_2_z

let test_dynamically_loaded_version_constants test_ctxt =
  let open Unsigned.UInt32 in
    let major = of_int32 GLib.Core.c_MAJOR_VERSION in
    let minor = of_int32 GLib.Core.c_MINOR_VERSION in
    let micro = of_int32 GLib.Core.c_MICRO_VERSION in
    match GLib.Core.check_version major minor micro with
    | None -> assert_equal_string "Ok" "Ok"
    | Some version_mismatch -> assert_equal_string "version mismatch" version_mismatch

let tests =
  "GLib constants tests" >:::
  [
    "Test boolean constant" >:: test_boolean_constant;
    "Test int8 constant" >:: test_int8_constant;
    "Test uint8 constant" >:: test_uint8_constant;
    "Test int16 constant" >:: test_int16_constant;
    "Test uint16 constant" >:: test_uint16_constant;
    "Test int32 constant" >:: test_int32_constant;
    "Test uint32 constant" >:: test_uint32_constant;
    "Test int64 constant" >:: test_int64_constant;
    "Test uint64 constant" >:: test_uint64_constant;
    "Test double constant" >:: test_double_constant;
    "Test string constant" >:: test_string_constant;
    "Test dynamically loader version constants" >:: test_dynamically_loaded_version_constants
  ]
