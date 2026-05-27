## fp_oa_fetch_dois() ----

test_that("fp_oa_fetch_dois() errors", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_oa_fetch_dois_error", {
    expect_error(
      fp_oa_fetch_dois(""),
      "OpenAlex request failed"
    )
  })
})


test_that("fp_oa_fetch_dois() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_oa_fetch_dois_onematch", {
    res <- fp_oa_fetch_dois(article_title, n = 10)
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 1L)
  expect_equal(ncol(res), 13L)

  expect_true(
    all(
      c("display_name", "publication_year", "source_display_name", "doi") %in%
        names(res)
    )
  )

  expect_equal(res[1, "display_name"], article_title)
  expect_equal(res[1, "publication_year"], 2026)

  vcr::use_cassette("fp_oa_fetch_dois_manymatches", {
    res <- fp_oa_fetch_dois("Citation landscape", n = 10)
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 10L)
  expect_equal(ncol(res), 13L)

  expect_true(
    all(
      c("display_name", "publication_year", "source_display_name", "doi") %in%
        names(res)
    )
  )

  vcr::use_cassette("fp_oa_fetch_dois_manymatches_w_n", {
    res <- fp_oa_fetch_dois("Citation landscape", n = 3)
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 3L)
  expect_equal(ncol(res), 13L)

  expect_true(
    all(
      c("display_name", "publication_year", "source_display_name", "doi") %in%
        names(res)
    )
  )

  vcr::use_cassette("fp_oa_fetch_dois_nomatches", {
    res <- suppressWarnings(fp_oa_fetch_dois("jsdhvgaekgrvge", n = 10))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 0L)
  expect_equal(ncol(res), 0L)
})
