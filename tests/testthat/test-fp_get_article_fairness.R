## fp_get_article_fairness() ----

test_that("fp_get_article_fairness() errors - No API query", {
  # Argument missing
  expect_error(
    fp_get_article_fairness(),
    "Argument 'doi' is required",
    fixed = TRUE
  )

  expect_error(
    fp_get_article_fairness(NULL),
    "Argument 'doi' is required",
    fixed = TRUE
  )

  # Not a string
  expect_error(
    fp_get_article_fairness(data.frame()),
    "Argument 'doi' must be character",
    fixed = TRUE
  )

  expect_error(
    fp_get_article_fairness(matrix()),
    "Argument 'doi' must be character",
    fixed = TRUE
  )

  expect_error(
    fp_get_article_fairness(numeric()),
    "Argument 'doi' must be character",
    fixed = TRUE
  )

  expect_error(
    fp_get_article_fairness(logical()),
    "Argument 'doi' must be character",
    fixed = TRUE
  )

  # Wrong length
  expect_error(
    fp_get_article_fairness(dois),
    "Argument 'doi' must be of length 1",
    fixed = TRUE
  )

  # API credentials
  expect_error(
    fp_get_article_fairness(dois[1]),
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
    fp_get_article_fairness(dois[1]),
    paste0(
      "Be polite with OpenAlex API and run: ",
      "`options(openalexR.mailto = 'your_email')`"
    ),
    fixed = TRUE
  )

  # Only NA in DOI
  expect_error(
    fp_get_article_fairness(doi_na),
    "Argument 'doi' cannot be NA",
    fixed = TRUE
  )
})

test_that("fp_get_article_fairness() works - With API query", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  # Test for NP journal
  vcr::use_cassette("fp_get_article_fairness_np", {
    expect_silent(res <- fp_get_article_fairness(dois[1]))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], "Science")
  expect_equal(res[1, "fairness"], "Non-profit and academic friendly")

  # Test for FP & non-academic journal
  vcr::use_cassette("fp_get_article_fairness_fp_non_acad", {
    expect_silent(res <- fp_get_article_fairness(dois[3]))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], "Ecology Letters")
  expect_equal(res[1, "fairness"], "For-profit and academic friendly")

  # Test for FP & academic journal
  vcr::use_cassette("fp_get_article_fairness_fp_acad", {
    expect_silent(res <- fp_get_article_fairness(dois[2]))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], "Nature")
  expect_equal(res[1, "fairness"], "For-profit and non-academic friendly")

  # Test for not found in OpenAlex
  vcr::use_cassette("fp_get_article_fairness_not_in_oa", {
    expect_silent(res <- fp_get_article_fairness(dois[4]))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_true(is.na(res[1, "journal"]))
  expect_equal(res[1, "fairness"], "Record not found in OpenAlex")

  # Test for not found in OpenAlex
  vcr::use_cassette("fp_get_article_fairness_not_in_dafnee", {
    expect_silent(res <- fp_get_article_fairness(dois[5]))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], "The Journal of Open Source Software")
  expect_equal(res[1, "fairness"], "Record not found in DAFNEE database")
})
