## fp_get_openalex_author() ----

test_that("fp_get_openalex_author() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_get_openalex_author", {
    res <- fp_get_openalex_author("Nicolas Casajus")
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 1L)
  expect_equal(ncol(res), 4L)
  
  expect_true(
    all(c("id", "display_name", "orcid", "works_count") %in% names(res))
  )

  expect_equal(res[1, "display_name"], "Nicolas Casajus")
  expect_equal(res[1, "orcid"], "0000-0002-5537-5294")
})
