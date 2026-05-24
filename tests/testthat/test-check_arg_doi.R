## check_arg_doi() ----

test_that("check_arg_doi() errors - Wrong type", {
  expect_error(
    check_arg_doi(),
    "Argument 'doi' is required",
    fixed = TRUE
  )

  expect_error(
    check_arg_doi(NULL),
    "Argument 'doi' is required",
    fixed = TRUE
  )

  expect_error(
    check_arg_doi(data.frame()),
    "Argument 'doi' must be a character",
    fixed = TRUE
  )

  expect_error(
    check_arg_doi(matrix()),
    "Argument 'doi' must be a character",
    fixed = TRUE
  )

  expect_error(
    check_arg_doi(numeric()),
    "Argument 'doi' must be a character",
    fixed = TRUE
  )

  expect_error(
    check_arg_doi(logical()),
    "Argument 'doi' must be a character",
    fixed = TRUE
  )
})

test_that("check_arg_doi() works", {
  expect_invisible(check_arg_doi(dois))
})
