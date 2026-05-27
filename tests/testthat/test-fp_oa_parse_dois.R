## fp_oa_parse_dois() ----

test_that("fp_oa_parse_dois() works", {
  raw <- data.frame(
    display_name = article_title,
    doi = "https://doi.org/10.1093/biosci/biag028",
    publication_year = 2026,
    source_display_name = "BioScience",
    extra = FALSE
  )

  expect_silent(res <- fp_oa_parse_dois(raw))

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 1L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(
      c("source_display_name", "display_name", "doi", "publication_year") %in%
        names(res)
    )
  )

  expect_false("extra" %in% names(res))

  expect_equal(res[1, "source_display_name"], "BioScience")
  expect_equal(
    res[1, "display_name"],
    "Citation self-awareness for a fairer academic..."
  )
  expect_equal(res[1, "doi"], "10.1093/biosci/biag028")
  expect_equal(res[1, "publication_year"], 2026L)

  expect_silent(res <- fp_oa_parse_dois(data.frame()))

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 0L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(
      c("source_display_name", "display_name", "doi", "publication_year") %in%
        names(res)
    )
  )

  expect_false("extra" %in% names(res))
})
