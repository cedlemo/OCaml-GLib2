open Ctypes

type t
val t_typ : t structure typ
val f_julian_days: (Unsigned.uint32, t structure) field
val f_julian: (Unsigned.uint32, t structure) field
val f_dmy: (Unsigned.uint32, t structure) field
val f_day: (Unsigned.uint32, t structure) field
val f_month: (Unsigned.uint32, t structure) field
val f_year: (Unsigned.uint32, t structure) field
(* Not implemented g_date_new return type not handled . *)
(* Not implemented g_date_new_dmy return type not handled . *)
(* Not implemented g_date_new_julian return type not handled . *)
val add_days:
t structure ptr -> Unsigned.uint32 -> unit
val add_months:
t structure ptr -> Unsigned.uint32 -> unit
val add_years:
t structure ptr -> Unsigned.uint32 -> unit
(* Not implemented g_date_clamp argument types not handled . *)
val clear:
t structure ptr -> Unsigned.uint32 -> unit
(* Not implemented g_date_compare argument types not handled . *)
(* Not implemented g_date_days_between argument types not handled . *)
val free:
t structure ptr -> unit
val get_day:
t structure ptr -> Unsigned.uint8
val get_day_of_year:
t structure ptr -> Unsigned.uint32
val get_iso8601_week_of_year:
t structure ptr -> Unsigned.uint32
val get_julian:
t structure ptr -> Unsigned.uint32
val get_monday_week_of_year:
t structure ptr -> Unsigned.uint32
val get_month:
t structure ptr -> Core.datemonth
val get_sunday_week_of_year:
t structure ptr -> Unsigned.uint32
val get_weekday:
t structure ptr -> Core.dateweekday
val get_year:
t structure ptr -> Unsigned.uint16
val is_first_of_month:
t structure ptr -> bool
val is_last_of_month:
t structure ptr -> bool
(* Not implemented g_date_order argument types not handled . *)
val set_day:
t structure ptr -> Unsigned.uint8 -> unit
val set_dmy:
t structure ptr -> Unsigned.uint8 -> Core.datemonth -> Unsigned.uint16 -> unit
val set_julian:
t structure ptr -> Unsigned.uint32 -> unit
val set_month:
t structure ptr -> Core.datemonth -> unit
val set_parse:
t structure ptr -> string -> unit
val set_time:
t structure ptr -> int32 -> unit
val set_time_t:
t structure ptr -> int64 -> unit
(* Not implemented g_date_set_time_val argument types not handled . *)
val set_year:
t structure ptr -> Unsigned.uint16 -> unit
val subtract_days:
t structure ptr -> Unsigned.uint32 -> unit
val subtract_months:
t structure ptr -> Unsigned.uint32 -> unit
val subtract_years:
t structure ptr -> Unsigned.uint32 -> unit
val to_struct_tm:
t structure ptr -> unit ptr -> unit
val valid:
t structure ptr -> bool
val get_days_in_month:
t structure ptr -> Core.datemonth -> Unsigned.uint16 -> Unsigned.uint8
val get_monday_weeks_in_year:
t structure ptr -> Unsigned.uint16 -> Unsigned.uint8
val get_sunday_weeks_in_year:
t structure ptr -> Unsigned.uint16 -> Unsigned.uint8
val is_leap_year:
t structure ptr -> Unsigned.uint16 -> bool
(* Not implemented g_date_strftime argument types not handled . *)
val valid_day:
t structure ptr -> Unsigned.uint8 -> bool
val valid_dmy:
t structure ptr -> Unsigned.uint8 -> Core.datemonth -> Unsigned.uint16 -> bool
val valid_julian:
t structure ptr -> Unsigned.uint32 -> bool
val valid_month:
t structure ptr -> Core.datemonth -> bool
val valid_weekday:
t structure ptr -> Core.dateweekday -> bool
val valid_year:
t structure ptr -> Unsigned.uint16 -> bool

