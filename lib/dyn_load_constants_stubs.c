#include <glib.h>
#include <caml/mlvalues.h>

CAMLprim value
get_major_version () {
    return Val_int (GLIB_MAJOR_VERSION);
}

CAMLprim value
get_minor_version () {
    return Val_int (GLIB_MINOR_VERSION);
}

CAMLprim value
get_micro_version () {
    return Val_int (GLIB_MICRO_VERSION);
}

