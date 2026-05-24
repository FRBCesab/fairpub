## check_exactly_one_arg() ----

test_that("check_exactly_one_arg() errors", {
  expect_error(
    check_exactly_one_arg(NULL, NULL),
    "You must supply exactly one of 'x' or 'file'",
    fixed = TRUE
  )

  expect_error(
    check_exactly_one_arg("string", "string"),
    "You must supply exactly one of 'x' or 'file'",
    fixed = TRUE
  )
})

test_that("check_exactly_one_arg() works", {
  expect_invisible(check_exactly_one_arg("string", NULL))
  expect_invisible(check_exactly_one_arg(NULL, "string"))
})
