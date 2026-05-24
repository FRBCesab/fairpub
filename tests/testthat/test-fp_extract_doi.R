## fp_extract_doi() ----

filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

test_that("fp_extract_doi() works", {
  expect_silent(dois <- fp_extract_doi(filename))

  dois <- fp_extract_doi(filename)

  # Class
  expect_true(inherits(dois, "character"))
  expect_equal(length(dois), 38L)
  expect_true(any(is.na(dois)))

  # Cleaned DOI
  pos <- grep("^doi:", dois)
  expect_equal(length(pos), 0L)

  pos <- grep("^http", dois)
  expect_equal(length(pos), 0L)

  pos <- grep("[A-Z]", dois)
  expect_equal(length(pos), 0L)
})
