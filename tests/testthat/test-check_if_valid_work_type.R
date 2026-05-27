## check_if_valid_work_type() ----

test_that("check_if_valid_work_type() errors", {
  expect_error(
    check_if_valid_work_type("foobar"),
    regexp = "Invalid 'select' argument"
  )

  expect_error(
    check_if_valid_work_type(c("article", "foobar")),
    regexp = "Invalid 'select' argument"
  )
})


test_that("check_if_valid_work_type() works", {
  expect_no_error(
    check_if_valid_work_type("article")
  )

  expect_no_error(
    check_if_valid_work_type(c("article", "book", "review"))
  )

  result <- check_if_valid_work_type("article")
  expect_null(result)

  valid_types <- fp_list_openalex_work_types()

  expect_no_error(
    check_if_valid_work_type(valid_types)
  )
})
