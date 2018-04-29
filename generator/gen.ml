module BG = GI_bindings_generator
module Loader = BG.Loader

(* let print_infos loader =
  let namespace = Loader.get_namespace loader in
  let version = Loader.get_version loader in
  print_endline (">> " ^ namespace);
  print_endline ("\t - version :" ^ version) *)


let () =
  (* match Loader.load "GLib" () with
  | Error message -> print_endline "Please check the namespace, something is wrong"
  | Ok loader ->
      let _ = print_infos loader in *)
      Loader.write_bindings_for "GLib" ["Error"]
