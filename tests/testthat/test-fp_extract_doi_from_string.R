## fp_extract_doi_from_string() ----

test_that("fp_extract_doi_from_string() works", {
  expect_silent(res <- fp_extract_doi_from_string(x = texte))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), 4L)
  expect_false(any(is.na(res)))

  expect_equal(res[1], "10.1093/biosci/biag028")
  expect_equal(res[2], "DOI: 10.32942/X24933")
  expect_equal(res[3], "http://dx.doi.org/10.1162/qss(c)_00305")
  expect_equal(res[4], "https://doi.org/10.1111/ele.14395")
})
