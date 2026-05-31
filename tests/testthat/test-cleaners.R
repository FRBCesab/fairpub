## fp_clean_*() ----

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


test_that("fp_clean_oa_id() works", {
  expect_silent(res <- fp_clean_oa_id(oa_author_id))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), length(oa_author_id))

  expect_equal(res, "A5004806463")
})


test_that("fp_clean_orcid() works", {
  expect_silent(res <- fp_clean_orcid(orcid))

  expect_true(inherits(res, "character"))
  expect_equal(length(res), length(orcid))

  expect_equal(res, "0000-0002-5537-5294")
})


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
