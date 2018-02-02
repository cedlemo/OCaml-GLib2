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
open Unix
open Ctypes

let test_get_ymd test_ctxt =
  let now = GLib.Date_time.new_now_local () in
  let (year, month, day) = GLib.Date_time.get_ymd now in
  let now' = Unix.time () in
  let tm = Unix.gmtime now' in
  let _ = assert_equal_int32 (Int32.of_int (tm.tm_year + 1900)) year in
  let _ = assert_equal_int32 (Int32.of_int (tm.tm_mon + 1)) month in
  let _ = assert_equal_int32 (Int32.of_int tm.tm_mday) day in
  GLib.Date_time.unref now

let tests =
  "GLib2 Date_time module data and functions tests" >:::
    [
      "test get ymd" >:: test_get_ymd;
    ]
