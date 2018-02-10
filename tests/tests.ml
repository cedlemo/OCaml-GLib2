open OUnit2

let () =
  run_test_tt_main
  ("GLib2 tests" >:::
    [
      Test_constants.tests;
      Test_enums.tests;
      Test_functions.tests;
      Test_date.tests;
      Test_random.tests;
      Test_date_time.tests;
      Test_time_val.tests;
    ]
  )
