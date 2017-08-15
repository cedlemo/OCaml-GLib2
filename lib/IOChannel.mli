open Ctypes

type t
val t_typ : t structure typ
val f_ref_count: (int32, t structure) field
(* TODO Struct field IOChannel : struct tag not implemented . *)
val f_encoding: (string, t structure) field
(* TODO Struct field IOChannel : struct tag not implemented . *)
(* TODO Struct field IOChannel : struct tag not implemented . *)
val f_line_term: (string, t structure) field
val f_line_term_len: (Unsigned.uint32, t structure) field
val f_buf_size: (Unsigned.uint64, t structure) field
(* TODO Struct field IOChannel : struct tag not implemented . *)
(* TODO Struct field IOChannel : struct tag not implemented . *)
(* TODO Struct field IOChannel : struct tag not implemented . *)
(* TODO Struct field IOChannel : C Array type for GITypes.Array tag tag not implemented . *)
val f_use_buffer: (Unsigned.uint32, t structure) field
val f_do_encode: (Unsigned.uint32, t structure) field
val f_close_on_unref: (Unsigned.uint32, t structure) field
val f_is_readable: (Unsigned.uint32, t structure) field
val f_is_writeable: (Unsigned.uint32, t structure) field
val f_is_seekable: (Unsigned.uint32, t structure) field
val f_reserved1: (unit ptr, t structure) field
val f_reserved2: (unit ptr, t structure) field
(* Not implemented g_io_channel_new_file return type not handled . *)
(* Not implemented g_io_channel_unix_new return type not handled . *)
val close:
t structure ptr -> unit
val flush:
t structure ptr -> Error.t structure ptr ptr option -> Core.iostatus
val get_buffer_condition:
t structure ptr -> Core.iocondition_list
val get_buffer_size:
t structure ptr -> Unsigned.uint64
val get_buffered:
t structure ptr -> bool
val get_close_on_unref:
t structure ptr -> bool
val get_encoding:
t structure ptr -> string
val get_flags:
t structure ptr -> Core.ioflags_list
val get_line_term:
t structure ptr -> int32 ptr -> string
val init:
t structure ptr -> unit
val read:
t structure ptr -> string -> Unsigned.uint64 -> Unsigned.uint64 ptr -> Core.ioerror
(* Not implemented g_io_channel_read_chars argument types not handled . *)
(* Not implemented g_io_channel_read_line argument types not handled . *)
(* Not implemented g_io_channel_read_line_string argument types not handled . *)
(* Not implemented g_io_channel_read_to_end argument types not handled . *)
(* Not implemented g_io_channel_read_unichar argument types not handled . *)
(* Not implemented g_io_channel_ref return type not handled . *)
val seek:
t structure ptr -> int64 -> Core.seektype -> Core.ioerror
val seek_position:
t structure ptr -> int64 -> Core.seektype -> Error.t structure ptr ptr option -> Core.iostatus
val set_buffer_size:
t structure ptr -> Unsigned.uint64 -> unit
val set_buffered:
t structure ptr -> bool -> unit
val set_close_on_unref:
t structure ptr -> bool -> unit
val set_encoding:
t structure ptr -> string option -> Error.t structure ptr ptr option -> Core.iostatus
val set_flags:
t structure ptr -> Core.ioflags_list -> Error.t structure ptr ptr option -> Core.iostatus
val set_line_term:
t structure ptr -> string option -> int32 -> unit
val shutdown:
t structure ptr -> bool -> Error.t structure ptr ptr option -> Core.iostatus
val unix_get_fd:
t structure ptr -> int32
val unref:
t structure ptr -> unit
val write:
t structure ptr -> string -> Unsigned.uint64 -> Unsigned.uint64 ptr -> Core.ioerror
(* Not implemented g_io_channel_write_chars argument types not handled . *)
(* Not implemented g_io_channel_write_unichar argument types not handled . *)
val error_from_errno:
t structure ptr -> int32 -> Core.iochannelerror
val error_quark:
t structure ptr -> Unsigned.uint32

