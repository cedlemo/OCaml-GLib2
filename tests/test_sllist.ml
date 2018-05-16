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
open Ctypes
open GLib.SLList

module Int_list =
    GLib.SLList.Make(struct
                    type t = int
                    type ctype = int
                    let t_typ = int
                  end)

let test_list_int_append test_ctxt =
  let v = allocate int 1 in
  let sllist = Int_list.append None v in
  let v = allocate int 2 in
  let sllist = Int_list.append sllist v in
  let length = Int_list.length sllist in
  assert_equal ~printer:Unsigned.UInt.to_string Unsigned.UInt.(of_int 2) length

let one = allocate int 1
let two = allocate int 2
let three = allocate int 3

let build_sllist () =
  let sllist = Int_list.append None one in
  let sllist = Int_list.append sllist two in
  Int_list.append sllist three

let test_list_int_next test_ctxt =
  let sllist = build_sllist () in
  let _ = match Int_list.data sllist with
    | None -> assert_failure "The next node should have data"
    | Some v -> assert_equal_int 1 v
  in
  let elt = Int_list.next sllist in
  let _ = match Int_list.data elt with
    | None -> assert_failure "The next node should have data"
    | Some v -> assert_equal_int 2 v
  in
  let elt = Int_list.next elt in
  match Int_list.data elt with
  | None -> assert_failure "The next node should have data"
  | Some v -> assert_equal_int 3 v

let tests =
  "GLib2 Sl List module tests" >:::
    [
      "Sl list of int create append length test" >:: test_list_int_append;
      "Sl list of int next test" >:: test_list_int_next;
    ]
