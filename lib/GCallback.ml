(*
 * Copyright 2018 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-GLib2.
 *
 * OCaml-GLib2 is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-GLib2 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-GLib2.  If not, see <http://www.gnu.org/licenses/>.
 *)

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

module GFunc = struct
  module Make(Data : DataType) = struct
    type data = Data.t
    let data = Data.t_typ
    let f = ptr data @-> ptr_opt void @-> returning void
    let funptr = funptr f
  end
end

module GHashFunc = struct
  module Make(Data : DataType) = struct
    type data = Data.t
    let data = Data.t_typ
    let f = ptr data @-> returning uint
    let funptr = funptr f
  end
end
