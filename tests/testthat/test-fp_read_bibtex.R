## fp_read_bibtex() ----

test_that("fp_read_bibtex() works", {
  expect_no_message(x <- fp_read_bibtex(filename))
  expect_length(x, 38L)
  expect_equal(x[1]$doi, "10.1098/rsos.160384")
  expect_null(x[2]$doi)
})
