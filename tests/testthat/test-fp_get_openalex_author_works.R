## fp_get_openalex_author_works() ----

test_that("fp_get_openalex_author_works() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_get_openalex_author_works_nosel_nodrop", {
    res <- fp_get_openalex_author_works(
      "A5004806463",
      select = NULL,
      drop_na = FALSE
    )
  })

  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) >= 102L)
  expect_equal(ncol(res), 9L)

  vcr::use_cassette("fp_get_openalex_author_works_sel_nodrop", {
    res <- fp_get_openalex_author_works(
      "A5004806463",
      drop_na = FALSE
    )
  })

  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) >= 44L)
  expect_equal(ncol(res), 9L)

  vcr::use_cassette("fp_get_openalex_author_works_sel_drop", {
    res <- fp_get_openalex_author_works(
      "A5004806463"
    )
  })

  expect_true(inherits(res, "data.frame"))
  expect_true(nrow(res) >= 41L)
  expect_equal(ncol(res), 9L)
})
