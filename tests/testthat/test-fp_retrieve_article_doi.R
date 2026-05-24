## fp_retrieve_article_doi() ----

test_that("fp_retrieve_article_doi() errors - No API query", {
  expect_error(
    fp_retrieve_article_doi(article_title),
    paste0(
      "Be polite with OpenAlex API and run: ",
      "`options(openalexR.mailto = 'your_email')`"
    ),
    fixed = TRUE
  )

  withr::local_options(
    list("openalexR.mailto" = NULL)
  )

  expect_error(
    fp_retrieve_article_doi(article_title),
    paste0(
      "Be polite with OpenAlex API and run: ",
      "`options(openalexR.mailto = 'your_email')`"
    ),
    fixed = TRUE
  )
})


test_that("fp_retrieve_article_doi() errors - API query", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_retrieve_article_doi_error", {
    expect_error(
      fp_retrieve_article_doi(""),
      "Failed to retrieve data from OpenAlex",
      fixed = TRUE
    )
  })
})


test_that("fp_retrieve_article_doi() works - API query", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_retrieve_article_doi_onematch", {
    res <- fp_retrieve_article_doi(article_title)
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

  vcr::use_cassette("fp_retrieve_article_doi_manymatches", {
    res <- fp_retrieve_article_doi("Citation landscape")
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 5L)
  expect_equal(ncol(res), 4L)

  vcr::use_cassette("fp_retrieve_article_doi_manymatches_w_n", {
    res <- fp_retrieve_article_doi("Citation landscape", n = 3)
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 3L)
  expect_equal(ncol(res), 4L)

  vcr::use_cassette("fp_retrieve_article_doi_nomatch", {
    res <- suppressWarnings(fp_retrieve_article_doi("kjdhfgvlzjegvz"))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 0L)
  expect_equal(ncol(res), 4L)

  expect_true("display_name" %in% colnames(res))
  expect_true("publication_year" %in% colnames(res))
  expect_true("source_display_name" %in% colnames(res))
  expect_true("doi" %in% colnames(res))
})
