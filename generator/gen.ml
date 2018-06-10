module BG = GI_bindings_generator
module Loader = BG.Loader

(** The namespace to be loaded: ie. the lib for which the bindings will be
 *  generated. *)
let namespace = "GLib"

let version = "2.0"

(** A suffix for the filenames of the raw bindings of the Core part. For example,
 *  all the constants and functions defined directly in the namespace are defined
 *  in a "Core" module and generated in "Core.ml" and "Core.mli" files. But, in
 *  in order to be able to tweak those automatically generated bindings, a
 *  suffix is added. Here, all the constants and functions of the namespaces
 *  will be found in the module Core_raw. Then in the lib/Core.ml file, I just
 *  load/open the Core_raw. *)
let files_suffix = "Raw"

(** Instead of generate all the data structures (and theirs related methods or
 *  constants), the idea is to choose what is needed. *)
let data_structures =
  ["Error"; "Rand"; "Date"; "DateTime"; "TimeVal"; "TimeZone";]

(** One can choose to skip the bindings of some constants because they are not
 *  needed or because you want to create manually the bindings in the "Core.ml"
 *  file. *)
let const_to_skip = ["MAJOR_VERSION"; "MINOR_VERSION"; "MICRO_VERSION"]

(** Like for the data_structures, you have to choose with function should have
 *  its bindings generated. *)
let functions = ["random_double"; "random_double_range";
                 "random_int"; "random_int_range";
                 "get_current_time";
                 "filename_to_uri"; "get_charset";
                 "dir_make_tmp"]

let sources = Loader.generate_files ("Core" ^ files_suffix)

let () =
  let () = Loader.write_constant_bindings_for namespace ~version sources const_to_skip in
  let () = Loader.write_function_bindings_for namespace ~version sources functions in
  let () = Loader.write_enum_and_flag_bindings_for namespace ~version () in
  let () = Loader.write_bindings_for namespace ~version data_structures in
  BG.Binding_utils.Sources.close sources
