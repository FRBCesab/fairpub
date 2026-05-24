## fp_extract_doi() ----

test_that("fp_extract_doi() works", {
  expect_silent(res <- fp_extract_doi(filename))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), 38L)
  expect_true(any(is.na(res)))

  expect_equal(length(grep("^doi:", res)), 0L)
  expect_equal(length(grep("^http", res)), 0L)
  expect_equal(length(grep("[A-Z]", res)), 0L)
})
