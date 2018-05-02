module BG = GI_bindings_generator
module Loader = BG.Loader

let namespace = "GLib"
let files_suffix = "Raw"

let data_structures = ["Error"; "Rand"; "Date"; "DateTime"; "TimeVal"; "TimeZone"]

let const_to_skip = ["MAJOR_VERSION"; "MINOR_VERSION"; "MICRO_VERSION"]

let () =
  let _ = Loader.write_constant_bindings_for namespace ~files_suffix const_to_skip in
  let _ = Loader.write_enum_and_flag_bindings_for namespace in
  Loader.write_bindings_for namespace data_structures
