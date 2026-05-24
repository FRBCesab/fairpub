## fp_extract_doi_from_bibentry() ----

test_that("fp_extract_doi_from_bibentry() works", {
  expect_no_message(res <- fp_extract_doi_from_bibentry(refs))
  expect_length(res, 38L)
  expect_equal(res[1], "10.1098/rsos.160384")
  expect_true(is.na(res[2]))
})
