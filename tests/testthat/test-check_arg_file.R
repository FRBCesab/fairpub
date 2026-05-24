## check_arg_file() ----

filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

test_that("check_arg_file() errors - Wrong type", {
  expect_error(
    check_arg_file(),
    "Argument 'file' is required",
    fixed = TRUE
  )

  expect_error(
    check_arg_file(NULL),
    "Argument 'file' is required",
    fixed = TRUE
  )

  expect_error(
    check_arg_file(data.frame()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    check_arg_file(matrix()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    check_arg_file(numeric()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    check_arg_file(logical()),
    "Argument 'file' must be a character (BibTeX file name)",
    fixed = TRUE
  )

  expect_error(
    check_arg_file(rep(filename, 2)),
    "Argument 'file' must be of length 1 (one BibTeX file)",
    fixed = TRUE
  )
})

test_that("check_arg_file() errors - File doesn't exist", {
  expect_error(
    check_arg_file("./wrong_path.bib"),
    "The file './wrong_path.bib' does not exist",
    fixed = TRUE
  )
})


test_that("check_arg_file() works", {})
