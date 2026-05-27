## fp_oa_fetch_works() ----

test_that("fp_oa_fetch_works() errors", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_oa_fetch_works_error", {
    expect_error(
      fp_oa_fetch_works(""),
      "OpenAlex request failed"
    )
  })
})


test_that("fp_oa_fetch_works() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_oa_fetch_works_match", {
    res <- fp_oa_fetch_works("A5004806463")
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 43L)
  expect_true(nrow(res) >= 102L)

  cols <- c(
    "id",
    "authorships",
    "title",
    "publication_year",
    "source_display_name",
    "source_id",
    "doi",
    "cited_by_count",
    "type"
  )

  expect_true(
    all(cols %in% names(res))
  )

  vcr::use_cassette("fp_oa_fetch_works_nomatches", {
    res <- suppressWarnings(fp_oa_fetch_works("A99999999999"))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 0L)
  expect_equal(ncol(res), 0L)
})
