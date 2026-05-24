## fp_extract_doi() ----

test_that("fp_extract_doi() works - BibTeX file", {
  expect_silent(res <- fp_extract_doi(file = filename))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), 38L)
  expect_true(any(is.na(res)))

  expect_equal(length(grep("^doi:", res)), 0L)
  expect_equal(length(grep("^http", res)), 0L)
  expect_equal(length(grep("[A-Z]", res)), 0L)
})

test_that("fp_extract_doi() works - Character vector", {
  expect_silent(res <- fp_extract_doi(x = texte))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), 4L)
  expect_false(any(is.na(res)))

  expect_equal(res[1], "10.1093/biosci/biag028")
  expect_equal(res[2], "10.32942/x24933")
  expect_equal(res[3], "10.1162/qss(c)_00305")
  expect_equal(res[4], "10.1111/ele.14395")
})
