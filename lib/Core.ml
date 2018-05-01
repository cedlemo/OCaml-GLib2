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
