open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "SourceCallbackFuncs"
(* TODO Struct field SourceCallbackFuncs : callback tag not implemented . *)
(* TODO Struct field SourceCallbackFuncs : callback tag not implemented . *)
let f_get = field t_typ "get" (ptr void)

