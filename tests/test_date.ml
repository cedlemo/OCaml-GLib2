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

let test_get_days_in_month test_ctxt =
  let open Unsigned in
  let n_days = GLib.Date.get_days_in_month November (UInt16.of_int 2017) in
  assert_equal_int 30 (UInt8.to_int n_days)

let test_date_create test_ctxt =
  let open GLib in
  let open Unsigned in
  let date = Date.create () in
  let day = UInt8.of_int 30 in
  let month = Date_month.November in
  let year = UInt16.of_int 2017 in
  let _ = Date.set_day date day in
  let _ = Date.set_month date month in
  let _ = Date.set_year date year in
  let _ = assert_equal_uint8 (Date.get_day date) day in
  let _ = assert_equal (Date.get_month date) month in
  let _ = assert_equal_uint16 (Date.get_year date) year in
  Date.free date

let tests =
  "GLib2 Date module data and functions tests" >:::
    [
      "test get days in month" >:: test_get_days_in_month;
      "Test create date" >:: test_date_create
    ]
