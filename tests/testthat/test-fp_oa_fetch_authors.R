## fp_oa_fetch_authors() ----

test_that("fp_oa_fetch_authors() errors", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_retrieve_author_oa_id_error", {
    expect_error(
      fp_retrieve_author_oa_id(""),
      "OpenAlex request failed"
    )
  })
})


test_that("fp_oa_fetch_authors() works", {
  withr::local_options(
    list("openalexR.mailto" = "anonymous@mail.com")
  )

  vcr::use_cassette("fp_retrieve_author_oa_id_onematch", {
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

  vcr::use_cassette("fp_retrieve_author_oa_id_manymatches", {
    res <- fp_retrieve_author_oa_id("Nicolas")
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 10L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(c("id", "display_name", "orcid", "works_count") %in% names(res))
  )

  vcr::use_cassette("fp_retrieve_author_oa_id_manymatches_w_n", {
    res <- fp_retrieve_author_oa_id("Nicolas", n = 20)
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 20L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(c("id", "display_name", "orcid", "works_count") %in% names(res))
  )

  vcr::use_cassette("fp_retrieve_author_oa_id_nomatches", {
    res <- suppressWarnings(fp_retrieve_author_oa_id("jsdhvgaekgrvge"))
  })

  expect_true(inherits(res, "data.frame"))
  expect_equal(nrow(res), 0L)
  expect_equal(ncol(res), 4L)

  expect_true(
    all(c("id", "display_name", "orcid", "works_count") %in% names(res))
  )
})
