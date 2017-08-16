open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "TestSuite"
let add =
foreign "g_test_suite_add" (ptr t_typ @-> ptr TestCase.t_typ @-> returning (void))
let add_suite =
foreign "g_test_suite_add_suite" (ptr t_typ @-> ptr t_typ @-> returning (void))

