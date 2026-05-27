## fp_get_openalex_doi() ----

test_that("fp_get_openalex_doi() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_get_openalex_doi", {
    res <- fp_get_openalex_doi(article_title)
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 1L)
  expect_equal(ncol(res), 4L)

  expect_equal(
    res[1, "display_name"],
    "Citation self-awareness for a fairer academic..."
  )

  expect_equal(
    res[1, "publication_year"],
    2026
  )

  expect_equal(
    res[1, "source_display_name"],
    "BioScience"
  )

  expect_equal(
    res[1, "doi"],
    "10.1093/biosci/biag028"
  )
})
