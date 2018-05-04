module BG = GI_bindings_generator
module Loader = BG.Loader

let namespace = "GLib"

let files_suffix = "Raw"

let data_structures = ["Error"; "Rand"; "Date"; "DateTime"; "TimeVal"; "TimeZone"]

let const_to_skip = ["MAJOR_VERSION"; "MINOR_VERSION"; "MICRO_VERSION"]

let functions = ["random_double"; "random_double_range";
                 "random_int"; "random_int_range";
                 "get_current_time"]

let sources = Loader.generate_files ("Core" ^ files_suffix)
let () =
  let _ = Loader.write_constant_bindings_for namespace sources const_to_skip in
  let _ = Loader.write_function_bindings_for namespace sources functions in
  let _ = Loader.write_enum_and_flag_bindings_for namespace in
  let _ = Loader.write_bindings_for namespace data_structures in
  BG.Binding_utils.Sources.close sources
