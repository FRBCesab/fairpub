## fp_retrieve_author_oa_id() ----

test_that("fp_retrieve_author_oa_id() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_retrieve_author_oa_id", {
    res <- fp_retrieve_author_oa_id("Nicolas Casajus")
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
