module BG = GI_bindings_generator
module Loader = BG.Loader

let data_structures = ["Error"; "Rand"; "Date"; "DateTime"; "TimeVal"; "TimeZone"]

let constants_to_skip = ["MAJOR_VERSION"; "MINOR_VERSION"; "MICRO_VERSION"]

let () =
  let files_suffix = "Raw" in
  let _ = Loader.write_constant_bindings_for "GLib" ~files_suffix constants_to_skip in
  let _ = Loader.write_enum_and_flag_bindings_for "GLib" in
  Loader.write_bindings_for "GLib" data_structures
