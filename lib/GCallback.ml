open Ctypes
open Foreign

module type DataType = sig
  type t
  val t_typ : t Ctypes.typ
end

(** CompareFunc functor.
 * Functor that generates a Ctypes signature for argument that are callback.
 * It is used in DLList and SLList for example.*)
module CompareFunc = struct
  module Make(Data : DataType) = struct
    type data = Data.t
    let data = Data.t_typ
    let f = ptr data @-> ptr data @-> returning int
    let funptr = funptr f
  end
end

module GDestroyNotify = struct
  module Make(Data : DataType) = struct
    type data = Data.t
    let data = Data.t_typ
    let f = ptr data @-> returning void
    let funptr = funptr f
  end
end
