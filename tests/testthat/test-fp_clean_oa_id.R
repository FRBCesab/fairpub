## fp_clean_oa_id() ----

test_that("fp_clean_oa_id() works", {
  expect_silent(res <- fp_clean_oa_id(oa_id))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), length(oa_id))

  expect_equal(res, "A5004806463")

})
