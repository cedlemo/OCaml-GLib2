module BG = GI_bindings_generator
module Loader = BG.Loader

let data_structures = ["Error"; "Rand"; "Date"; "DateTime"; "TimeVal"; "TimeZone"]

let () =
  let _ = Loader.write_constant_bindings_for "GLib" [] [] in
  Loader.write_bindings_for "GLib" data_structures
