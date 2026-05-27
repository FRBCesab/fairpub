## fp_clean_orcid() ----

test_that("fp_clean_orcid() works", {
  expect_silent(res <- fp_clean_orcid(orcid))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), length(orcid))

  expect_equal(res, "0000-0002-5537-5294")

})
