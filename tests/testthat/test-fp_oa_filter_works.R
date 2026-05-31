## fp_oa_filter_works() ----

test_that("fp_oa_filter_works filters() works - Selected work types", {
  x <- data.frame(
    type = c("article", "book", "review"),
    source_display_name = c("Nature", "Springer", "Science"),
    doi = c("a", "b", "c")
  )

  res <- fp_oa_filter_works(
    x = x,
    select = c("article", "review"),
    drop_na = FALSE
  )

  expect_equal(res$type, c("article", "review"))
})

test_that("fp_oa_filter_works() works - Removes dataset repositories", {
  x <- data.frame(
    type = c("article", "dataset"),
    source_display_name = c("Zenodo", "Figshare"),
    doi = c("a", "b")
  )

  res <- fp_oa_filter_works(
    x = x,
    select = "article",
    drop_na = FALSE
  )

  expect_equal(nrow(res), 0L)
})

test_that("fp_oa_filter_works() works - Keeps dataset repositories", {
  x <- data.frame(
    type = c("dataset", "dataset"),
    source_display_name = c("Zenodo", "Figshare"),
    doi = c("a", "b")
  )

  res <- fp_oa_filter_works(
    x = x,
    select = "dataset",
    drop_na = FALSE
  )

  expect_equal(nrow(res), 2L)
})

test_that("fp_oa_filter_works() works - Removes preprint repositories", {
  x <- data.frame(
    type = c("article", "article", "article"),
    source_display_name = c("HAL", "bioRxiv", "EcoEvoRxiv"),
    doi = c("a", "b", "c")
  )

  res <- fp_oa_filter_works(
    x = x,
    select = "article",
    drop_na = FALSE
  )

  expect_equal(nrow(res), 0L)
})

test_that("fp_oa_filter_works() works - Keeps preprint repositories", {
  x <- data.frame(
    type = c("preprint", "preprint"),
    source_display_name = c("HAL", "bioRxiv"),
    doi = c("a", "b")
  )

  res <- fp_oa_filter_works(
    x = x,
    select = "preprint",
    drop_na = FALSE
  )

  expect_equal(nrow(res), 2L)
})

test_that("fp_oa_filter_works() works - Drops rows with missing doi/source", {
  x <- data.frame(
    type = c("article", "article", "article"),
    source_display_name = c("Nature", NA, "Science"),
    doi = c("a", "b", NA)
  )

  res <- fp_oa_filter_works(
    x = x,
    select = NULL,
    drop_na = TRUE
  )

  expect_equal(nrow(res), 1L)
  expect_equal(res$source_display_name, "Nature")
})

test_that("fp_oa_filter_works() works - Keeps NA rows when drop_na is FALSE", {
  x <- data.frame(
    type = c("article", "article"),
    source_display_name = c("Nature", NA),
    doi = c("a", NA)
  )

  res <- fp_oa_filter_works(
    x = x,
    select = NULL,
    drop_na = FALSE
  )

  expect_equal(nrow(res), 2L)
})

test_that("fp_oa_filter_works() works - No rows", {
  x <- data.frame(
    type = character(),
    source_display_name = character(),
    doi = character()
  )

  res <- fp_oa_filter_works(
    x = x,
    select = NULL,
    drop_na = FALSE
  )

  expect_equal(nrow(res), 0L)
})

test_that("fp_oa_filter_works() errors - Invalid select values", {
  x <- data.frame(
    type = "article",
    source_display_name = "Nature",
    doi = "a"
  )

  expect_error(
    fp_oa_filter_works(
      x = x,
      select = "foobar",
      drop_na = FALSE
    ),
    regexp = "Invalid `select` argument"
  )
})
