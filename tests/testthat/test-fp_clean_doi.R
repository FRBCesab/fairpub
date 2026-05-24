## fp_clean_doi() ----

test_that("fp_clean_doi() works", {
  expect_silent(res <- fp_clean_doi(doi_to_clean))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), length(doi_to_clean))
  expect_true(any(is.na(res)))

  expect_equal(length(grep("^doi:", res)), 0L)
  expect_equal(length(grep("^http", res)), 0L)
  expect_equal(length(grep("[A-Z]", res)), 0L)
  expect_equal(length(grep("\\s", res)), 0L)

  unique_values <- unique(res)
  
  expect_true(length(unique_values) == 2L)
  expect_true("10.1098/rsos.160384" %in% unique_values)
  expect_true(NA %in% unique_values)
})
