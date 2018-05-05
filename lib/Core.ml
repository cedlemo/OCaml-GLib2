open Ctypes
open Foreign

include Core_raw


external get_major_version: unit -> int = "get_major_version"
let c_MAJOR_VERSION = get_major_version () |> Int32.of_int

external get_minor_version: unit -> int = "get_minor_version"
let c_MINOR_VERSION = get_minor_version () |> Int32.of_int

external get_micro_version: unit -> int = "get_micro_version"
let c_MICRO_VERSION = get_micro_version () |> Int32.of_int

let check_version =
  foreign "glib_check_version" (uint32_t @-> uint32_t @-> uint32_t @-> returning (string_opt))

let filename_from_uri uri =
  let filename_from_uri_raw =
    foreign "g_filename_from_uri" (string @-> ptr (string_opt) @-> ptr (ptr_opt Error.t_typ) @-> returning (string_opt))
  in
  let err_ptr_ptr = allocate (ptr_opt Error.t_typ) None in
  let hostname_ptr = allocate string_opt None in
  let ret = filename_from_uri_raw uri hostname_ptr err_ptr_ptr in
  let get_ret_value () =
    let hostname = !@ hostname_ptr in
    (ret, hostname)
  in
  match (!@ err_ptr_ptr) with
  | None -> Ok (get_ret_value ())
  | Some _ -> let err_ptr = !@ err_ptr_ptr in
    let _ = Gc.finalise (function | Some e -> Error.free e | None -> () ) err_ptr in
    Error (err_ptr)

