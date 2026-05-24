## check_arg_n() ----

test_that("check_arg_n() errors", {
  expect_error(
    check_arg_n(NULL),
    "Argument 'n' is required",
    fixed = TRUE
  )

  expect_error(
    check_arg_n("12"),
    "Argument 'n' must be an integer",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(rep(12, 2)),
    "Argument 'n' must be of length 1",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(Inf),
    "Argument 'n' must be finite",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(-Inf),
    "Argument 'n' must be finite",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(NA_integer_),
    "Argument 'n' must be finite",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(12.4),
    "Argument 'n' must be an integer",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(-12.4),
    "Argument 'n' must be an integer",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(0),
    "Argument 'n' must be a positive integer between 1 and 200",
    fixed = TRUE
  )

  expect_error(
    check_arg_n(201),
    "Argument 'n' must be a positive integer between 1 and 200",
    fixed = TRUE
  )
})

test_that("check_arg_n() works", {
  expect_silent(check_arg_n(10))
})
