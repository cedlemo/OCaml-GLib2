module BG = GI_bindings_generator
module Loader = BG.Loader

let data_structures = ["Error"; "Rand"; "Date"; "DateTime"; "TimeVal"; "TimeZone"]

let () =
      Loader.write_bindings_for "GLib" data_structures
