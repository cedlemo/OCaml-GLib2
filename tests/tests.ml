open OUnit2

let () =
  run_test_tt_main
  ("GLib2 tests" >:::
    [
      Constant.tests
    ]
  )
