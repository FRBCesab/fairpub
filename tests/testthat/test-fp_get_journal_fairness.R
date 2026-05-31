## fp_get_journal_fairness() ----

test_that("fp_get_journal_fairness() errors", {
  # Argument missing
  expect_error(
    fp_get_journal_fairness(),
    "Argument `journal` must be a character vector of length 1.",
    fixed = TRUE
  )

  expect_error(
    fp_get_journal_fairness(NULL),
    "Argument `journal` must be a character vector of length 1.",
    fixed = TRUE
  )

  # Wrong length
  expect_error(
    fp_get_journal_fairness(journals),
    "Argument `journal` must be a character vector of length 1.",
    fixed = TRUE
  )

  # Only NA in DOI
  expect_error(
    fp_get_journal_fairness(journal_na),
    "Argument `journal` must be a character vector of length 1.",
    fixed = TRUE
  )
})

test_that("Test fp_get_journal_fairness() works", {
  # Test for exact match
  expect_silent(res <- fp_get_journal_fairness(journals[1]))

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], journals[1])
  expect_equal(res[1, "fairness"], "Non-profit and academic friendly")

  # Test for fuzzy suggestions
  expect_invisible(suppressMessages(fp_get_journal_fairness(journals[2])))
  expect_message(res <- fp_get_journal_fairness(journals[2]))

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_true(is.na(res[1, "journal"]))
  expect_true(is.na(res[1, "fairness"]))

  # Test for suggested match
  expect_silent(res <- fp_get_journal_fairness(journals[3]))

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], journals[3])
  expect_equal(res[1, "fairness"], "For-profit and non-academic friendly")

  # Test for the third fairness category
  expect_silent(res <- fp_get_journal_fairness(journals[4]))

  expect_true(inherits(res, "data.frame"))
  expect_equal(ncol(res), 2L)
  expect_equal(nrow(res), 1L)

  expect_true("journal" %in% colnames(res))
  expect_true("fairness" %in% colnames(res))

  expect_equal(res[1, "journal"], journals[4])
  expect_equal(res[1, "fairness"], "For-profit and academic friendly")
})
