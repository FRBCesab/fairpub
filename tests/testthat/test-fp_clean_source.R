## fp_clean_source() ----

test_that("fp_clean_source() works", {
  res <- fp_clean_source("Nature (London)")
  expect_type(res, "character")

  expect_equal(
    fp_clean_source("Nature (London)"),
    "Nature"
  )

  expect_equal(
    fp_clean_source("Science (New York, N.Y.)"),
    "Science"
  )

  expect_equal(
    fp_clean_source("Nature"),
    "Nature"
  )

  expect_equal(
    fp_clean_source("Journal of Ecology"),
    "Journal of Ecology"
  )

  input <- c(
    "Nature (London)",
    "Science",
    "Cell (Cambridge)"
  )

  expected <- c(
    "Nature",
    "Science",
    "Cell"
  )

  expect_equal(
    fp_clean_source(input),
    expected
  )

  expect_equal(
    fp_clean_source(""),
    ""
  )

  expect_true(is.na(fp_clean_source(NA)))
})
