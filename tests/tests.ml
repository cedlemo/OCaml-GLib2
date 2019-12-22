open OUnit2

let () =
  run_test_tt_main
  ("GLib2 tests" >:::
    [
      Test_constants.tests;
      Test_enums.tests;
      Test_date.tests;
      Test_date_time.tests;
      Test_random.tests;
      Test_functions.tests;
      Test_dllist.tests;
      Test_sllist.tests;
      Test_hash_table.tests;
      Test_c_string_utilities.tests;
    ]
  )
