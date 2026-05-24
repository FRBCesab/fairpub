## fp_extract_doi_from_bibentry() ----

filename <- system.file(
  file.path("extdata", "references.bib"),
  package = "fairpub"
)

refs <- fp_read_bibtex(filename)

test_that("fp_extract_doi_from_bibentry() works", {
  expect_no_message(x <- fp_extract_doi_from_bibentry(refs))
  expect_length(x, 38L)
  expect_equal(x[1], "10.1098/rsos.160384")
  expect_true(is.na(x[2]))
})
