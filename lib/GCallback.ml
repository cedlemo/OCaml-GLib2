open Ctypes
open Foreign

module type DataType = sig
  type t
  val t_typ : t Ctypes.typ
end

module CompareFunc = struct
  module Make(Data : DataType) = struct
    type data = Data.t
    let data = Data.t_typ
    let f = ptr data @-> ptr data @-> returning int
    let funptr = funptr f
  end
end
