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
    let t_typ = int
    let free_func = None
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

let build_int_sllist () =
  let sllist = Int_list.append None one in
  let sllist = Int_list.append sllist two in
  Int_list.append sllist three

let test_list_int_next test_ctxt =
  let sllist = build_int_sllist () in
  let values = [1; 2; 3] in
  let rec check_loop elt = function
    | [] -> ()
    | h :: q ->
      let _ = match Int_list.get_data elt with
        | None -> assert_failure "The next node should have data"
        | Some v -> assert_equal_int h (!@v)
      in
      let next = Int_list.next elt in
      check_loop next q
  in check_loop sllist values

let assert_node node value printer =
  match Int_list.get_data node with
  | None ->
    let msg = "This node should have data" in
    assert_equal ~msg false true
  | Some v ->
    assert_equal ~printer value (!@v)

let test_list_int_last test_ctxt =
  let sllist = build_int_sllist () in
  match Int_list.last sllist with
  | None ->
    let msg = "the last element of the sllist should not be none"
    in assert_equal ~msg false true
  | last -> assert_node last 3 string_of_int

let test_list_int_nth test_ctxt =
  let sllist = build_int_sllist () in
  let () = assert_node (Int_list.nth sllist 0) 1 string_of_int in
  let () = assert_node (Int_list.nth sllist 1) 2 string_of_int in
  assert_node (Int_list.nth sllist 2) 3 string_of_int

let test_list_int_sort test_ctxt =
  let sllist = build_int_sllist () in
  let sllist = Int_list.sort sllist (fun ptr_a ptr_b ->
      let a = !@ptr_a in
      let b = !@ptr_b in
      if a = b then 0
      else if a > b then 1
      else -1)
  in
  match Int_list.last sllist with
  | None ->
    let msg = "the last element of the dllist should not be none"
    in assert_equal ~msg false true
  | last -> assert_node last 3 string_of_int

let test_list_int_concat test_ctxt =
  let sllist = build_int_sllist () in
  let sllist' = Int_list.append None (allocate int 4) in
  let sllist' = Int_list.append sllist' (allocate int 5) in
  let sllist' = Int_list.append sllist' (allocate int 6) in
  let sllist'' = Int_list.concat sllist sllist' in
  let () = assert_node (Int_list.nth sllist'' 0) 1 string_of_int in
  let () = assert_node (Int_list.nth sllist'' 1) 2 string_of_int in
  let () = assert_node (Int_list.nth sllist'' 2) 3 string_of_int in
  let () = assert_node (Int_list.nth sllist'' 3) 4 string_of_int in
  let () = assert_node (Int_list.nth sllist'' 4) 5 string_of_int in
  assert_node (Int_list.nth sllist 5) 6 string_of_int

let test_list_int_free_full test_ctxt =
  let counter = ref 0 in
  let module Int_list =
    GLib.SLList.Make(struct
      type t = int
      let t_typ = int
      let free_func = Some (fun v ->
          counter := (!counter + (!@v)))
  end)
  in
  (** In the following lines, the finalise is disabled in order so that the
   *  values are not de-allocated by the Gc.full_major. If the Garbage Collector
   *  clean those values, the test fails because !@v reference freed memory
   *  zone. *)
  let sllist = Int_list.append None (allocate ~finalise:(fun _-> ()) int 4) in
  let sllist = Int_list.append sllist (allocate ~finalise:(fun _-> ()) int 5) in
  let _ = Int_list.append sllist (allocate ~finalise:(fun _-> ()) int 6) in
  let () = Gc.full_major () in
  assert_equal_int 15 (!counter)

module Char_ptr_list =
  GLib.SLList.Make(struct
    type t = char
    let t_typ = char
    let free_func = None
  end)

let s_one = GLib.Core.string_to_char_ptr "one"
let s_two = GLib.Core.string_to_char_ptr "two"
let s_three = GLib.Core.string_to_char_ptr "three"

let build_char_ptr_sllist () =
  let sllist = Char_ptr_list.append None s_one in
  let sllist = Char_ptr_list.append sllist s_two in
  Char_ptr_list.append sllist s_three

let test_list_char_ptr_append_length test_ctxt =
  let sllist = build_char_ptr_sllist () in
  let ref_len = Unsigned.UInt.of_int 3 in
  let len = Char_ptr_list.length sllist in
  let printer = Unsigned.UInt.to_string in
  assert_equal ~printer ref_len len

let test_list_char_ptr_next test_ctxt =
  let sllist = build_char_ptr_sllist () in
  let node = Char_ptr_list.next sllist in
  let _ = match Char_ptr_list.get_data node with
    | None -> assert_failure "The next node should have data"
    | Some v ->
      let str = GLib.Core.char_ptr_to_string v in
      assert_equal_string str "two"
  in
  let node = Char_ptr_list.next node in
  match Char_ptr_list.get_data node with
  | None -> assert_failure "The next node should have data"
  | Some v ->
    let str = GLib.Core.char_ptr_to_string v in
    assert_equal_string str "three"

let tests =
  "GLib2 Sl List module tests" >:::
  [
    "Sl list of int create append length test" >:: test_list_int_append;
    "Sl list of int next test" >:: test_list_int_next;
    "Sl list of int last test" >:: test_list_int_last;
    "Sl list of int sort test" >:: test_list_int_sort;
    "Sl list of int nth test" >:: test_list_int_nth;
    "Sl list of int concat test" >:: test_list_int_concat;
    "Sl list of int free_full test" >:: test_list_int_free_full;
    "SL list of char ptr append length test" >:: test_list_char_ptr_append_length;
    "SL list of char ptr next" >:: test_list_char_ptr_next;
  ]
