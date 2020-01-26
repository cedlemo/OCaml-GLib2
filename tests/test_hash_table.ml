(*
 * Copyright 2018-2020 Cedric LE MOIGNE, cedlemo@gmx.com
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
open GLib

module String_hash =
  GLib.Hash_table.Make(struct
    type key = char
    let key = char
    type value = char
    let value = char
    let key_destroy_func = None
    let value_destroy_func = None
  end)

let build_hash_sample () =
  let h = String_hash.create Core.str_hash Core.str_equal in
  let france = GLib.Core.string_to_char_ptr "france" in
  let paris = GLib.Core.string_to_char_ptr "paris" in
  let () = String_hash.insert h france paris in
  let allemagne = GLib.Core.string_to_char_ptr "allemagne" in
  let berlin = GLib.Core.string_to_char_ptr "berlin" in
  let () = String_hash.insert h allemagne berlin in
  h

let test_hash_table_create_insert_size test_ctxt =
  let h = build_hash_sample () in
  let s = String_hash.size h in
  let s_ref = Unsigned.UInt.of_int 2 in
  let printer = Unsigned.UInt.to_string in
  assert_equal ~printer s_ref s

let test_hash_table_lookup test_ctxt =
  let h = build_hash_sample () in
  let espagne = GLib.Core.string_to_char_ptr "espagne" in
  let () = match String_hash.lookup h espagne with
    | Some _ -> let msg ="Lookup bad key: this should not have been reached" in
      assert_equal ~msg false true
    | None -> ()
  in
  let allemagne = GLib.Core.string_to_char_ptr "allemagne" in
  match String_hash.lookup h allemagne with
  | None -> let msg ="Lookup good key: this should not have been reached" in
    assert_equal ~msg false true
  | Some capital ->
    let printer = fun s -> s in
    assert_equal ~printer (GLib.Core.char_ptr_to_string capital) "berlin"

let test_hash_table_lookup_extended test_ctxt =
  let h = build_hash_sample () in
  let espagne = GLib.Core.string_to_char_ptr "espagne" in
  let () = match String_hash.lookup_extended h espagne with
    | Some _ -> let msg ="Lookup bad key: this should not have been reached" in
      assert_equal ~msg false true
    | None -> ()
  in
  let allemagne = GLib.Core.string_to_char_ptr "allemagne" in
  match String_hash.lookup_extended h allemagne with
  | None -> let msg ="Lookup good key: this should not have been reached" in
    assert_equal ~msg false true
  | Some (key, value) ->
    let printer = fun s -> s in
    let () = assert_equal ~printer (GLib.Core.char_ptr_to_string key) "allemagne" in
    assert_equal ~printer (GLib.Core.char_ptr_to_string value) "berlin"

let test_hash_table_foreach test_ctxt =
  let h = build_hash_sample () in
  let buf = ref "" in
  let () = String_hash.foreach h (fun k v ->
      let key = GLib.Core.char_ptr_to_string k in
      let value = GLib.Core.char_ptr_to_string v in
      buf := String.concat " " [!buf ; key; value] ) in
  let printer = fun s -> s in
  let expected = " allemagne berlin france paris" in
  assert_equal ~printer expected !buf

let test_hash_table_create_full test_ctxt =
  let counter_key = ref 0 in
  let counter_val = ref 0 in
  let module Int_hash_wth_destroy =
    GLib.Hash_table.Make(struct
      type key = int
      let key = int
      type value = int
      let value = int
      let key_destroy_func = Some (fun v -> counter_key := (!counter_key + (!@v)))
      let value_destroy_func = Some (fun v -> counter_val := (!counter_val + (!@v)))
    end)
  in
  let h = Int_hash_wth_destroy.create_full Core.int_hash Core.int_equal in
  let insert_vals key value =
    let value = allocate ~finalise:(fun _-> ()) int value in
    let key =  allocate ~finalise:(fun _-> ()) int key in
    Int_hash_wth_destroy.insert h key value
  in
  let () = insert_vals 1 4 in
  let () = insert_vals 2 10 in
  let () = Gc.full_major () in
  let () = assert_equal_int 3 (!counter_key) in
  assert_equal_int 14 (!counter_val)

let tests =
  "GLib2 Hash_table module tests" >:::
  [
    "Test hash table create/insert/size" >:: test_hash_table_create_insert_size;
    "Test hash table lookup" >:: test_hash_table_lookup;
    "Test hash table lookup_extended" >:: test_hash_table_lookup_extended;
    "Test hash table foreach" >:: test_hash_table_foreach;
    "Test hash table create_full" >:: test_hash_table_create_full;
  ]
