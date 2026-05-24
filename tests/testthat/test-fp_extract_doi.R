# Example BibTeX
filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

test_that("Test fp_extract_doi() for error", {
  # Argument missing
  expect_error(
    fp_extract_doi(),
    "Argument 'file' is required",
    fixed = TRUE
  )

  expect_error(
    fp_extract_doi(NULL),
    "Argument 'file' is required",
    fixed = TRUE
  )

  # Not a file name
  expect_error(
    fp_extract_doi(data.frame()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    fp_extract_doi(matrix()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    fp_extract_doi(numeric()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    fp_extract_doi(logical()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  # Wrong length
  expect_error(
    fp_extract_doi(rep(filename, 2)),
    "Argument 'file' must be of length 1 (one BibTeX file)",
    fixed = TRUE
  )

  # File not found
  expect_error(
    fp_extract_doi("./wrong_path.bib"),
    "The file './wrong_path.bib' does not exist",
    fixed = TRUE
  )
})


test_that("Test fp_extract_doi() for success", {
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
