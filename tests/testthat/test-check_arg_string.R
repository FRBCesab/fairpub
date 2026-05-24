## check_arg_string() ----

test_that("check_arg_string() errors", {
  expect_error(
    check_arg_string(NULL),
    "Argument 'x' is required",
    fixed = TRUE
  )

  expect_error(
    check_arg_string(data.frame()),
    "Argument 'x' must be a character",
    fixed = TRUE
  )

  expect_error(
    check_arg_string(matrix()),
    "Argument 'x' must be a character",
    fixed = TRUE
  )

  expect_error(
    check_arg_string(numeric()),
    "Argument 'x' must be a character",
    fixed = TRUE
  )

  expect_error(
    check_arg_string(logical()),
    "Argument 'x' must be a character",
    fixed = TRUE
  )
})

test_that("check_arg_string() works", {
  expect_invisible(check_arg_string("string"))
})
