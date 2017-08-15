From d005deae542f5e508376f1af182d88d75211d62f Mon Sep 17 00:00:00 2001
From: cedlemo <cedlemo@gmx.com>
Date: Tue, 15 Aug 2017 15:31:41 +0200
Subject: [PATCH] Make Core.check_version returning string option type

---
 lib/core.ml  | 308 +++++++++++++++++++++++++++++------------------------------
 lib/core.mli |   2 +-
 2 files changed, 155 insertions(+), 155 deletions(-)

diff --git a/lib/core.ml b/lib/core.ml
index 0b7c2e7..39bace7 100644
--- a/lib/core.ml
+++ b/lib/core.ml
@@ -52,9 +52,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let asciitype_list = view 
-~read:asciitype_list_of_value 
-~write:asciitype_list_to_value 
+let asciitype_list = view
+~read:asciitype_list_of_value
+~write:asciitype_list_to_value
 uint32_t
 
 let _BIG_ENDIAN = Int32.of_string "4321"
@@ -79,9 +79,9 @@ let bookmarkfileerror_to_value = function
 | Unknown_encoding -> Unsigned.UInt32.of_int 5
 | Write -> Unsigned.UInt32.of_int 6
 | File_not_found -> Unsigned.UInt32.of_int 7
-let bookmarkfileerror = view 
-~read:bookmarkfileerror_of_value 
-~write:bookmarkfileerror_to_value 
+let bookmarkfileerror = view
+~read:bookmarkfileerror_of_value
+~write:bookmarkfileerror_to_value
 uint32_t
 
 let _CSET_A_2_Z = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
@@ -104,9 +104,9 @@ let checksumtype_to_value = function
 | Sha256 -> Unsigned.UInt32.of_int 2
 | Sha512 -> Unsigned.UInt32.of_int 3
 | Sha384 -> Unsigned.UInt32.of_int 4
-let checksumtype = view 
-~read:checksumtype_of_value 
-~write:checksumtype_to_value 
+let checksumtype = view
+~read:checksumtype_of_value
+~write:checksumtype_to_value
 uint32_t
 
 type converterror = No_conversion | Illegal_sequence | Failed | Partial_input | Bad_uri | Not_absolute_path | No_memory
@@ -127,9 +127,9 @@ let converterror_to_value = function
 | Bad_uri -> Unsigned.UInt32.of_int 4
 | Not_absolute_path -> Unsigned.UInt32.of_int 5
 | No_memory -> Unsigned.UInt32.of_int 6
-let converterror = view 
-~read:converterror_of_value 
-~write:converterror_to_value 
+let converterror = view
+~read:converterror_of_value
+~write:converterror_to_value
 uint32_t
 
 let _DATALIST_FLAGS_MASK = Int32.of_string "3"
@@ -154,9 +154,9 @@ let datedmy_to_value = function
 | Day -> Unsigned.UInt32.of_int 0
 | Month -> Unsigned.UInt32.of_int 1
 | Year -> Unsigned.UInt32.of_int 2
-let datedmy = view 
-~read:datedmy_of_value 
-~write:datedmy_to_value 
+let datedmy = view
+~read:datedmy_of_value
+~write:datedmy_to_value
 uint32_t
 
 type datemonth = Bad_month | January | February | March | April | May | June | July | August | September | October | November | December
@@ -189,9 +189,9 @@ let datemonth_to_value = function
 | October -> Unsigned.UInt32.of_int 10
 | November -> Unsigned.UInt32.of_int 11
 | December -> Unsigned.UInt32.of_int 12
-let datemonth = view 
-~read:datemonth_of_value 
-~write:datemonth_to_value 
+let datemonth = view
+~read:datemonth_of_value
+~write:datemonth_to_value
 uint32_t
 
 type dateweekday = Bad_weekday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
@@ -214,9 +214,9 @@ let dateweekday_to_value = function
 | Friday -> Unsigned.UInt32.of_int 5
 | Saturday -> Unsigned.UInt32.of_int 6
 | Sunday -> Unsigned.UInt32.of_int 7
-let dateweekday = view 
-~read:dateweekday_of_value 
-~write:dateweekday_to_value 
+let dateweekday = view
+~read:dateweekday_of_value
+~write:dateweekday_to_value
 uint32_t
 
 let _E = 2.718282
@@ -241,9 +241,9 @@ let errortype_to_value = function
 | Digit_radix -> Unsigned.UInt32.of_int 5
 | Float_radix -> Unsigned.UInt32.of_int 6
 | Float_malformed -> Unsigned.UInt32.of_int 7
-let errortype = view 
-~read:errortype_of_value 
-~write:errortype_to_value 
+let errortype = view
+~read:errortype_of_value
+~write:errortype_to_value
 uint32_t
 
 type fileerror = Exist | Isdir | Acces | Nametoolong | Noent | Notdir | Nxio | Nodev | Rofs | Txtbsy | Fault | Loop | Nospc | Nomem | Mfile | Nfile | Badf | Inval | Pipe | Again | Intr | Io | Perm | Nosys | Failed
@@ -300,9 +300,9 @@ let fileerror_to_value = function
 | Perm -> Unsigned.UInt32.of_int 22
 | Nosys -> Unsigned.UInt32.of_int 23
 | Failed -> Unsigned.UInt32.of_int 24
-let fileerror = view 
-~read:fileerror_of_value 
-~write:fileerror_to_value 
+let fileerror = view
+~read:fileerror_of_value
+~write:fileerror_to_value
 uint32_t
 
 type filetest = Is_regular | Is_symlink | Is_dir | Is_executable | Exists
@@ -340,9 +340,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let filetest_list = view 
-~read:filetest_list_of_value 
-~write:filetest_list_to_value 
+let filetest_list = view
+~read:filetest_list_of_value
+~write:filetest_list_to_value
 uint32_t
 
 type formatsizeflags = Default | Long_format | Iec_units
@@ -376,9 +376,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let formatsizeflags_list = view 
-~read:formatsizeflags_list_of_value 
-~write:formatsizeflags_list_to_value 
+let formatsizeflags_list = view
+~read:formatsizeflags_list_of_value
+~write:formatsizeflags_list_to_value
 uint32_t
 
 let _GINT16_FORMAT = "hi"
@@ -456,9 +456,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let hookflagmask_list = view 
-~read:hookflagmask_list_of_value 
-~write:hookflagmask_list_to_value 
+let hookflagmask_list = view
+~read:hookflagmask_list_of_value
+~write:hookflagmask_list_to_value
 uint32_t
 
 let _IEEE754_DOUBLE_BIAS = Int32.of_string "1023"
@@ -487,9 +487,9 @@ let iochannelerror_to_value = function
 | Overflow -> Unsigned.UInt32.of_int 6
 | Pipe -> Unsigned.UInt32.of_int 7
 | Failed -> Unsigned.UInt32.of_int 8
-let iochannelerror = view 
-~read:iochannelerror_of_value 
-~write:iochannelerror_to_value 
+let iochannelerror = view
+~read:iochannelerror_of_value
+~write:iochannelerror_to_value
 uint32_t
 
 type iocondition = In | Out | Pri | Err | Hup | Nval
@@ -529,9 +529,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let iocondition_list = view 
-~read:iocondition_list_of_value 
-~write:iocondition_list_to_value 
+let iocondition_list = view
+~read:iocondition_list_of_value
+~write:iocondition_list_to_value
 uint32_t
 
 type ioerror = None | Again | Inval | Unknown
@@ -546,9 +546,9 @@ let ioerror_to_value = function
 | Again -> Unsigned.UInt32.of_int 1
 | Inval -> Unsigned.UInt32.of_int 2
 | Unknown -> Unsigned.UInt32.of_int 3
-let ioerror = view 
-~read:ioerror_of_value 
-~write:ioerror_to_value 
+let ioerror = view
+~read:ioerror_of_value
+~write:ioerror_to_value
 uint32_t
 
 type ioflags = Append | Nonblock | Is_readable | Is_writable | Is_writeable | Is_seekable | Mask | Get_mask | Set_mask
@@ -594,9 +594,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let ioflags_list = view 
-~read:ioflags_list_of_value 
-~write:ioflags_list_to_value 
+let ioflags_list = view
+~read:ioflags_list_of_value
+~write:ioflags_list_to_value
 uint32_t
 
 type iostatus = Error | Normal | Eof | Again
@@ -611,9 +611,9 @@ let iostatus_to_value = function
 | Normal -> Unsigned.UInt32.of_int 1
 | Eof -> Unsigned.UInt32.of_int 2
 | Again -> Unsigned.UInt32.of_int 3
-let iostatus = view 
-~read:iostatus_of_value 
-~write:iostatus_to_value 
+let iostatus = view
+~read:iostatus_of_value
+~write:iostatus_to_value
 uint32_t
 
 let _KEY_FILE_DESKTOP_GROUP = "Desktop Entry"
@@ -682,9 +682,9 @@ let keyfileerror_to_value = function
 | Key_not_found -> Unsigned.UInt32.of_int 3
 | Group_not_found -> Unsigned.UInt32.of_int 4
 | Invalid_value -> Unsigned.UInt32.of_int 5
-let keyfileerror = view 
-~read:keyfileerror_of_value 
-~write:keyfileerror_to_value 
+let keyfileerror = view
+~read:keyfileerror_of_value
+~write:keyfileerror_to_value
 uint32_t
 
 type keyfileflags = None | Keep_comments | Keep_translations
@@ -718,9 +718,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let keyfileflags_list = view 
-~read:keyfileflags_list_of_value 
-~write:keyfileflags_list_to_value 
+let keyfileflags_list = view
+~read:keyfileflags_list_of_value
+~write:keyfileflags_list_to_value
 uint32_t
 
 let _LITTLE_ENDIAN = Int32.of_string "1234"
@@ -780,9 +780,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let loglevelflags_list = view 
-~read:loglevelflags_list_of_value 
-~write:loglevelflags_list_to_value 
+let loglevelflags_list = view
+~read:loglevelflags_list_of_value
+~write:loglevelflags_list_to_value
 int32_t
 
 type logwriteroutput = Handled | Unhandled
@@ -793,9 +793,9 @@ else raise (Invalid_argument "Unexpected LogWriterOutput value")
 let logwriteroutput_to_value = function
 | Handled -> Unsigned.UInt32.of_int 1
 | Unhandled -> Unsigned.UInt32.of_int 0
-let logwriteroutput = view 
-~read:logwriteroutput_of_value 
-~write:logwriteroutput_to_value 
+let logwriteroutput = view
+~read:logwriteroutput_of_value
+~write:logwriteroutput_to_value
 uint32_t
 
 let _MAJOR_VERSION = Int32.of_string "2"
@@ -867,9 +867,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let markupcollecttype_list = view 
-~read:markupcollecttype_list_of_value 
-~write:markupcollecttype_list_to_value 
+let markupcollecttype_list = view
+~read:markupcollecttype_list_of_value
+~write:markupcollecttype_list_to_value
 uint32_t
 
 type markuperror = Bad_utf8 | Empty | Parse | Unknown_element | Unknown_attribute | Invalid_content | Missing_attribute
@@ -890,9 +890,9 @@ let markuperror_to_value = function
 | Unknown_attribute -> Unsigned.UInt32.of_int 4
 | Invalid_content -> Unsigned.UInt32.of_int 5
 | Missing_attribute -> Unsigned.UInt32.of_int 6
-let markuperror = view 
-~read:markuperror_of_value 
-~write:markuperror_to_value 
+let markuperror = view
+~read:markuperror_of_value
+~write:markuperror_to_value
 uint32_t
 
 type markupparseflags = Do_not_use_this_unsupported_flag | Treat_cdata_as_text | Prefix_error_position | Ignore_qualified
@@ -928,9 +928,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let markupparseflags_list = view 
-~read:markupparseflags_list_of_value 
-~write:markupparseflags_list_to_value 
+let markupparseflags_list = view
+~read:markupparseflags_list_of_value
+~write:markupparseflags_list_to_value
 uint32_t
 
 type normalizemode = Default | Nfd | Default_compose | Nfc | All | Nfkd | All_compose | Nfkc
@@ -953,9 +953,9 @@ let normalizemode_to_value = function
 | Nfkd -> Unsigned.UInt32.of_int 2
 | All_compose -> Unsigned.UInt32.of_int 3
 | Nfkc -> Unsigned.UInt32.of_int 3
-let normalizemode = view 
-~read:normalizemode_of_value 
-~write:normalizemode_to_value 
+let normalizemode = view
+~read:normalizemode_of_value
+~write:normalizemode_to_value
 uint32_t
 
 let _OPTION_REMAINING = ""
@@ -970,9 +970,9 @@ let oncestatus_to_value = function
 | Notcalled -> Unsigned.UInt32.of_int 0
 | Progress -> Unsigned.UInt32.of_int 1
 | Ready -> Unsigned.UInt32.of_int 2
-let oncestatus = view 
-~read:oncestatus_of_value 
-~write:oncestatus_to_value 
+let oncestatus = view
+~read:oncestatus_of_value
+~write:oncestatus_to_value
 uint32_t
 
 type optionarg = None | String | Int | Callback | Filename | String_array | Filename_array | Double | Int64
@@ -997,9 +997,9 @@ let optionarg_to_value = function
 | Filename_array -> Unsigned.UInt32.of_int 6
 | Double -> Unsigned.UInt32.of_int 7
 | Int64 -> Unsigned.UInt32.of_int 8
-let optionarg = view 
-~read:optionarg_of_value 
-~write:optionarg_to_value 
+let optionarg = view
+~read:optionarg_of_value
+~write:optionarg_to_value
 uint32_t
 
 type optionerror = Unknown_option | Bad_value | Failed
@@ -1012,9 +1012,9 @@ let optionerror_to_value = function
 | Unknown_option -> Unsigned.UInt32.of_int 0
 | Bad_value -> Unsigned.UInt32.of_int 1
 | Failed -> Unsigned.UInt32.of_int 2
-let optionerror = view 
-~read:optionerror_of_value 
-~write:optionerror_to_value 
+let optionerror = view
+~read:optionerror_of_value
+~write:optionerror_to_value
 uint32_t
 
 type optionflags = None | Hidden | In_main | Reverse | No_arg | Filename | Optional_arg | Noalias
@@ -1058,9 +1058,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let optionflags_list = view 
-~read:optionflags_list_of_value 
-~write:optionflags_list_to_value 
+let optionflags_list = view
+~read:optionflags_list_of_value
+~write:optionflags_list_to_value
 uint32_t
 
 let _PDP_ENDIAN = Int32.of_string "3412"
@@ -1146,9 +1146,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let regexcompileflags_list = view 
-~read:regexcompileflags_list_of_value 
-~write:regexcompileflags_list_to_value 
+let regexcompileflags_list = view
+~read:regexcompileflags_list_of_value
+~write:regexcompileflags_list_to_value
 uint32_t
 
 type regexerror = Compile | Optimize | Replace | Match | Internal | Stray_backslash | Missing_control_char | Unrecognized_escape | Quantifiers_out_of_order | Quantifier_too_big | Unterminated_character_class | Invalid_escape_in_character_class | Range_out_of_order | Nothing_to_repeat | Unrecognized_character | Posix_named_class_outside_class | Unmatched_parenthesis | Inexistent_subpattern_reference | Unterminated_comment | Expression_too_large | Memory_error | Variable_length_lookbehind | Malformed_condition | Too_many_conditional_branches | Assertion_expected | Unknown_posix_class_name | Posix_collating_elements_not_supported | Hex_code_too_large | Invalid_condition | Single_byte_match_in_lookbehind | Infinite_loop | Missing_subpattern_name_terminator | Duplicate_subpattern_name | Malformed_property | Unknown_property | Subpattern_name_too_long | Too_many_subpatterns | Invalid_octal_value | Too_many_branches_in_define | Define_repetion | Inconsistent_newline_options | Missing_back_reference | Invalid_relative_reference | Backtracking_control_verb_argument_forbidden | Unknown_backtracking_control_verb | Number_too_big | Missing_subpattern_name | Missing_digit | Invalid_data_character | Extra_subpattern_name | Backtracking_control_verb_argument_required | Invalid_control_char | Missing_name | Not_supported_in_class | Too_many_forward_references | Name_too_long | Character_value_too_large
@@ -1269,9 +1269,9 @@ let regexerror_to_value = function
 | Too_many_forward_references -> Unsigned.UInt32.of_int 172
 | Name_too_long -> Unsigned.UInt32.of_int 175
 | Character_value_too_large -> Unsigned.UInt32.of_int 176
-let regexerror = view 
-~read:regexerror_of_value 
-~write:regexerror_to_value 
+let regexerror = view
+~read:regexerror_of_value
+~write:regexerror_to_value
 uint32_t
 
 type regexmatchflags = Anchored | Notbol | Noteol | Notempty | Partial | Newline_cr | Newline_lf | Newline_crlf | Newline_any | Newline_anycrlf | Bsr_anycrlf | Bsr_any | Partial_soft | Partial_hard | Notempty_atstart
@@ -1329,9 +1329,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let regexmatchflags_list = view 
-~read:regexmatchflags_list_of_value 
-~write:regexmatchflags_list_to_value 
+let regexmatchflags_list = view
+~read:regexmatchflags_list_of_value
+~write:regexmatchflags_list_to_value
 uint32_t
 
 let _SEARCHPATH_SEPARATOR = Int32.of_string "59"
@@ -1376,9 +1376,9 @@ let seektype_to_value = function
 | Cur -> Unsigned.UInt32.of_int 0
 | Set -> Unsigned.UInt32.of_int 1
 | End -> Unsigned.UInt32.of_int 2
-let seektype = view 
-~read:seektype_of_value 
-~write:seektype_to_value 
+let seektype = view
+~read:seektype_of_value
+~write:seektype_to_value
 uint32_t
 
 type shellerror = Bad_quoting | Empty_string | Failed
@@ -1391,9 +1391,9 @@ let shellerror_to_value = function
 | Bad_quoting -> Unsigned.UInt32.of_int 0
 | Empty_string -> Unsigned.UInt32.of_int 1
 | Failed -> Unsigned.UInt32.of_int 2
-let shellerror = view 
-~read:shellerror_of_value 
-~write:shellerror_to_value 
+let shellerror = view
+~read:shellerror_of_value
+~write:shellerror_to_value
 uint32_t
 
 type sliceconfig = Always_malloc | Bypass_magazines | Working_set_msecs | Color_increment | Chunk_sizes | Contention_counter
@@ -1412,9 +1412,9 @@ let sliceconfig_to_value = function
 | Color_increment -> Unsigned.UInt32.of_int 4
 | Chunk_sizes -> Unsigned.UInt32.of_int 5
 | Contention_counter -> Unsigned.UInt32.of_int 6
-let sliceconfig = view 
-~read:sliceconfig_of_value 
-~write:sliceconfig_to_value 
+let sliceconfig = view
+~read:sliceconfig_of_value
+~write:sliceconfig_to_value
 uint32_t
 
 type spawnerror = Fork | Read | Chdir | Acces | Perm | Too_big | Noexec | Nametoolong | Noent | Nomem | Notdir | Loop | Txtbusy | Io | Nfile | Mfile | Inval | Isdir | Libbad | Failed
@@ -1461,9 +1461,9 @@ let spawnerror_to_value = function
 | Isdir -> Unsigned.UInt32.of_int 17
 | Libbad -> Unsigned.UInt32.of_int 18
 | Failed -> Unsigned.UInt32.of_int 19
-let spawnerror = view 
-~read:spawnerror_of_value 
-~write:spawnerror_to_value 
+let spawnerror = view
+~read:spawnerror_of_value
+~write:spawnerror_to_value
 uint32_t
 
 type spawnflags = Default | Leave_descriptors_open | Do_not_reap_child | Search_path | Stdout_to_dev_null | Stderr_to_dev_null | Child_inherits_stdin | File_and_argv_zero | Search_path_from_envp | Cloexec_pipes
@@ -1511,9 +1511,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let spawnflags_list = view 
-~read:spawnflags_list_of_value 
-~write:spawnflags_list_to_value 
+let spawnflags_list = view
+~read:spawnflags_list_of_value
+~write:spawnflags_list_to_value
 uint32_t
 
 let _TIME_SPAN_DAY = 86400000000L
@@ -1534,9 +1534,9 @@ else raise (Invalid_argument "Unexpected TestFileType value")
 let testfiletype_to_value = function
 | Dist -> Unsigned.UInt32.of_int 0
 | Built -> Unsigned.UInt32.of_int 1
-let testfiletype = view 
-~read:testfiletype_of_value 
-~write:testfiletype_to_value 
+let testfiletype = view
+~read:testfiletype_of_value
+~write:testfiletype_to_value
 uint32_t
 
 type testlogtype = None | Error | Start_binary | List_case | Skip_case | Start_case | Stop_case | Min_result | Max_result | Message | Start_suite | Stop_suite
@@ -1567,9 +1567,9 @@ let testlogtype_to_value = function
 | Message -> Unsigned.UInt32.of_int 9
 | Start_suite -> Unsigned.UInt32.of_int 10
 | Stop_suite -> Unsigned.UInt32.of_int 11
-let testlogtype = view 
-~read:testlogtype_of_value 
-~write:testlogtype_to_value 
+let testlogtype = view
+~read:testlogtype_of_value
+~write:testlogtype_to_value
 uint32_t
 
 type testsubprocessflags = Stdin | Stdout | Stderr
@@ -1603,9 +1603,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let testsubprocessflags_list = view 
-~read:testsubprocessflags_list_of_value 
-~write:testsubprocessflags_list_to_value 
+let testsubprocessflags_list = view
+~read:testsubprocessflags_list_of_value
+~write:testsubprocessflags_list_to_value
 uint32_t
 
 type threaderror = Thread_error_again
@@ -1614,9 +1614,9 @@ if v = Unsigned.UInt32.of_int 0 then Thread_error_again
 else raise (Invalid_argument "Unexpected ThreadError value")
 let threaderror_to_value = function
 | Thread_error_again -> Unsigned.UInt32.of_int 0
-let threaderror = view 
-~read:threaderror_of_value 
-~write:threaderror_to_value 
+let threaderror = view
+~read:threaderror_of_value
+~write:threaderror_to_value
 uint32_t
 
 type timetype = Standard | Daylight | Universal
@@ -1629,9 +1629,9 @@ let timetype_to_value = function
 | Standard -> Unsigned.UInt32.of_int 0
 | Daylight -> Unsigned.UInt32.of_int 1
 | Universal -> Unsigned.UInt32.of_int 2
-let timetype = view 
-~read:timetype_of_value 
-~write:timetype_to_value 
+let timetype = view
+~read:timetype_of_value
+~write:timetype_to_value
 uint32_t
 
 type tokentype = Eof | Left_paren | Right_paren | Left_curly | Right_curly | Left_brace | Right_brace | Equal_sign | Comma | None | Error | Char | Binary | Octal | Int | Hex | Float | String | Symbol | Identifier | Identifier_null | Comment_single | Comment_multi
@@ -1684,9 +1684,9 @@ let tokentype_to_value = function
 | Identifier_null -> Unsigned.UInt32.of_int 267
 | Comment_single -> Unsigned.UInt32.of_int 268
 | Comment_multi -> Unsigned.UInt32.of_int 269
-let tokentype = view 
-~read:tokentype_of_value 
-~write:tokentype_to_value 
+let tokentype = view
+~read:tokentype_of_value
+~write:tokentype_to_value
 uint32_t
 
 type traverseflags = Leaves | Non_leaves | All | Mask | Leafs | Non_leafs
@@ -1726,9 +1726,9 @@ let acc' = logor acc v in
 logor_flags q acc'
 in
 logor_flags flags zero
-let traverseflags_list = view 
-~read:traverseflags_list_of_value 
-~write:traverseflags_list_to_value 
+let traverseflags_list = view
+~read:traverseflags_list_of_value
+~write:traverseflags_list_to_value
 uint32_t
 
 type traversetype = In_order | Pre_order | Post_order | Level_order
@@ -1743,9 +1743,9 @@ let traversetype_to_value = function
 | Pre_order -> Unsigned.UInt32.of_int 1
 | Post_order -> Unsigned.UInt32.of_int 2
 | Level_order -> Unsigned.UInt32.of_int 3
-let traversetype = view 
-~read:traversetype_of_value 
-~write:traversetype_to_value 
+let traversetype = view
+~read:traversetype_of_value
+~write:traversetype_to_value
 uint32_t
 
 let _UNICHAR_MAX_DECOMPOSITION_LENGTH = Int32.of_string "18"
@@ -1846,9 +1846,9 @@ let unicodebreaktype_to_value = function
 | Emoji_base -> Unsigned.UInt32.of_int 40
 | Emoji_modifier -> Unsigned.UInt32.of_int 41
 | Zero_width_joiner -> Unsigned.UInt32.of_int 42
-let unicodebreaktype = view 
-~read:unicodebreaktype_of_value 
-~write:unicodebreaktype_to_value 
+let unicodebreaktype = view
+~read:unicodebreaktype_of_value
+~write:unicodebreaktype_to_value
 uint32_t
 
 type unicodescript = Invalid_code | Common | Inherited | Arabic | Armenian | Bengali | Bopomofo | Cherokee | Coptic | Cyrillic | Deseret | Devanagari | Ethiopic | Georgian | Gothic | Greek | Gujarati | Gurmukhi | Han | Hangul | Hebrew | Hiragana | Kannada | Katakana | Khmer | Lao | Latin | Malayalam | Mongolian | Myanmar | Ogham | Old_italic | Oriya | Runic | Sinhala | Syriac | Tamil | Telugu | Thaana | Thai | Tibetan | Canadian_aboriginal | Yi | Tagalog | Hanunoo | Buhid | Tagbanwa | Braille | Cypriot | Limbu | Osmanya | Shavian | Linear_b | Tai_le | Ugaritic | New_tai_lue | Buginese | Glagolitic | Tifinagh | Syloti_nagri | Old_persian | Kharoshthi | Unknown | Balinese | Cuneiform | Phoenician | Phags_pa | Nko | Kayah_li | Lepcha | Rejang | Sundanese | Saurashtra | Cham | Ol_chiki | Vai | Carian | Lycian | Lydian | Avestan | Bamum | Egyptian_hieroglyphs | Imperial_aramaic | Inscriptional_pahlavi | Inscriptional_parthian | Javanese | Kaithi | Lisu | Meetei_mayek | Old_south_arabian | Old_turkic | Samaritan | Tai_tham | Tai_viet | Batak | Brahmi | Mandaic | Chakma | Meroitic_cursive | Meroitic_hieroglyphs | Miao | Sharada | Sora_sompeng | Takri | Bassa_vah | Caucasian_albanian | Duployan | Elbasan | Grantha | Khojki | Khudawadi | Linear_a | Mahajani | Manichaean | Mende_kikakui | Modi | Mro | Nabataean | Old_north_arabian | Old_permic | Pahawh_hmong | Palmyrene | Pau_cin_hau | Psalter_pahlavi | Siddham | Tirhuta | Warang_citi | Ahom | Anatolian_hieroglyphs | Hatran | Multani | Old_hungarian | Signwriting | Adlam | Bhaiksuki | Marchen | Newa | Osage | Tangut
@@ -2133,9 +2133,9 @@ let unicodescript_to_value = function
 | Newa -> Int32.of_int 135
 | Osage -> Int32.of_int 136
 | Tangut -> Int32.of_int 137
-let unicodescript = view 
-~read:unicodescript_of_value 
-~write:unicodescript_to_value 
+let unicodescript = view
+~read:unicodescript_of_value
+~write:unicodescript_to_value
 int32_t
 
 type unicodetype = Control | Format | Unassigned | Private_use | Surrogate | Lowercase_letter | Modifier_letter | Other_letter | Titlecase_letter | Uppercase_letter | Spacing_mark | Enclosing_mark | Non_spacing_mark | Decimal_number | Letter_number | Other_number | Connect_punctuation | Dash_punctuation | Close_punctuation | Final_punctuation | Initial_punctuation | Other_punctuation | Open_punctuation | Currency_symbol | Modifier_symbol | Math_symbol | Other_symbol | Line_separator | Paragraph_separator | Space_separator
@@ -2202,9 +2202,9 @@ let unicodetype_to_value = function
 | Line_separator -> Unsigned.UInt32.of_int 27
 | Paragraph_separator -> Unsigned.UInt32.of_int 28
 | Space_separator -> Unsigned.UInt32.of_int 29
-let unicodetype = view 
-~read:unicodetype_of_value 
-~write:unicodetype_to_value 
+let unicodetype = view
+~read:unicodetype_of_value
+~write:unicodetype_to_value
 uint32_t
 
 type userdirectory = Directory_desktop | Directory_documents | Directory_download | Directory_music | Directory_pictures | Directory_public_share | Directory_templates | Directory_videos | N_directories
@@ -2229,9 +2229,9 @@ let userdirectory_to_value = function
 | Directory_templates -> Unsigned.UInt32.of_int 6
 | Directory_videos -> Unsigned.UInt32.of_int 7
 | N_directories -> Unsigned.UInt32.of_int 8
-let userdirectory = view 
-~read:userdirectory_of_value 
-~write:userdirectory_to_value 
+let userdirectory = view
+~read:userdirectory_of_value
+~write:userdirectory_to_value
 uint32_t
 
 let _VA_COPY_AS_ARRAY = Int32.of_string "1"
@@ -2278,9 +2278,9 @@ let variantclass_to_value = function
 | Array -> Unsigned.UInt32.of_int 97
 | Tuple -> Unsigned.UInt32.of_int 40
 | Dict_entry -> Unsigned.UInt32.of_int 123
-let variantclass = view 
-~read:variantclass_of_value 
-~write:variantclass_to_value 
+let variantclass = view
+~read:variantclass_of_value
+~write:variantclass_to_value
 uint32_t
 
 type variantparseerror = Failed | Basic_type_expected | Cannot_infer_type | Definite_type_expected | Input_not_at_end | Invalid_character | Invalid_format_string | Invalid_object_path | Invalid_signature | Invalid_type_string | No_common_type | Number_out_of_range | Number_too_big | Type_error | Unexpected_token | Unknown_keyword | Unterminated_string_constant | Value_expected
@@ -2323,9 +2323,9 @@ let variantparseerror_to_value = function
 | Unknown_keyword -> Unsigned.UInt32.of_int 15
 | Unterminated_string_constant -> Unsigned.UInt32.of_int 16
 | Value_expected -> Unsigned.UInt32.of_int 17
-let variantparseerror = view 
-~read:variantparseerror_of_value 
-~write:variantparseerror_to_value 
+let variantparseerror = view
+~read:variantparseerror_of_value
+~write:variantparseerror_to_value
 uint32_t
 
 let _WIN32_MSG_HANDLE = Int32.of_string "19981206"
@@ -2483,7 +2483,7 @@ let chdir =
 foreign "g_chdir" (string @-> returning (int32_t))
 
 let check_version =
-foreign "glib_check_version" (uint32_t @-> uint32_t @-> uint32_t @-> returning (string))
+foreign "glib_check_version" (uint32_t @-> uint32_t @-> uint32_t @-> returning (string_opt))
 
 let checksum_type_get_length =
 foreign "g_checksum_type_get_length" (checksumtype @-> returning (int64_t))
diff --git a/lib/core.mli b/lib/core.mli
index 516edfb..cafc268 100644
--- a/lib/core.mli
+++ b/lib/core.mli
@@ -847,7 +847,7 @@ val chdir:
 string -> int32
 
 val check_version:
-Unsigned.uint32 -> Unsigned.uint32 -> Unsigned.uint32 -> string
+Unsigned.uint32 -> Unsigned.uint32 -> Unsigned.uint32 -> string option
 
 val checksum_type_get_length:
 checksumtype -> int64
-- 
2.14.1

