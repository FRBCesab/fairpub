## fp_oa_parse_authors() ----

test_that("fp_oa_parse_authors() works", {
  raw <- data.frame(
    id = "https://openalex.org/A5004806463",
    display_name = "Nicolas Casajus",
    orcid = "https://orcid.org/0000-0002-5537-5294",
    works_count = 102,
    extra = "ignore"
  )

  expect_silent(res <- fp_oa_parse_authors(raw))

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 1L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(c("id", "display_name", "orcid", "works_count") %in% names(res))
  )

  expect_false("extra" %in% names(res))

  expect_equal(res[1, "id"], "A5004806463")
  expect_equal(res[1, "display_name"], "Nicolas Casajus")
  expect_equal(res[1, "orcid"], "0000-0002-5537-5294")
  expect_equal(res[1, "works_count"], 102L)

  expect_silent(res <- fp_oa_parse_authors(data.frame()))

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 0L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(c("id", "display_name", "orcid", "works_count") %in% names(res))
  )

  expect_false("extra" %in% names(res))
})
