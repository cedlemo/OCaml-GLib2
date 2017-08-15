open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "TestLogBuffer"
(* TODO Struct field TestLogBuffer : struct tag not implemented . *)
let f_msgs = field t_typ "msgs" (ptr SList.t_typ)
let free =
foreign "g_test_log_buffer_free" (ptr t_typ @-> returning (void))
let push =
foreign "g_test_log_buffer_push" (ptr t_typ @-> uint32_t @-> ptr uint8_t @-> returning (void))

