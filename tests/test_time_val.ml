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

let test_time_val_from_iso8601 test_ctxt =
  let iso8601 = "2018-02-07T10:39:38Z" in
  match GLib.Time_val.from_iso8601 iso8601 with
  | (false, _) -> assert_equal ~msg:"No time val" true false
  | (true, tv) -> let dt = GLib.Date_time.create_from_timeval_utc (Ctypes.addr tv) in
    let (y,m,d) = GLib.Date_time.get_ymd dt in
    let _ = assert_equal_int32 (Int32.of_int 2018) y in
    let _ = assert_equal_int32 (Int32.of_int 2) m in
    assert_equal_int32 (Int32.of_int 07) d

let test_core_get_current_time_and_to_iso8601 test_ctxt =
  let tv = Ctypes.make GLib.Time_val.t_typ in
  let tv_ptr = Ctypes.addr tv in
  let _ = GLib.Core.get_current_time tv_ptr in
  match GLib.Time_val.to_iso8601 tv_ptr with
  | None -> assert_equal ~msg:"No iso8601 from Timeval" true false
  | Some iso8601 -> let now = GLib.Date_time.create_now_local () in
    let (year, month, day) = GLib.Date_time.get_ymd now in
    let dt = GLib.Date_time.create_from_timeval_utc tv_ptr in
    let (y,m,d) = GLib.Date_time.get_ymd dt in
    let _ = assert_equal_int32 year y in
    let _ = assert_equal_int32 month m in
    assert_equal_int32 day d

let tests =
  "GLib Time_val tests" >:::
    ["Test time_val from iso8601" >:: test_time_val_from_iso8601;
     "Test Core.get_current_time and time_val to iso8601" >:: test_core_get_current_time_and_to_iso8601;]
