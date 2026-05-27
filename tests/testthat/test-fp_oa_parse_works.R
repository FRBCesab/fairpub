## fp_oa_parse_works() ----

test_that("fp_oa_parse_works() works - Results", {

  x <- data.frame(
    id = c("https://openalex.org/W1", "https://openalex.org/W2"),
    title = c("Titre 1", "Titre 2"),
    publication_year = c(2020, 2021),
    source_display_name = c("Journal A", "Journal B"),
    source_id = c("https://openalex.org/S1", "https://openalex.org/S2"),
    doi = c("https://doi.org/10.1000/abc", "https://doi.org/10.1000/def"),
    cited_by_count = c(10, 20),
    type = c("article", "book"),
    stringsAsFactors = FALSE
  )

  testthat::local_mocked_bindings(
    show_works = function(x, simp_fun = identity) {
      list(
        first_author = c("Jane Doe", "Jane Doe"),
        last_author = c("Paul Smith", NA)
      )
    },
    .package = "openalexR"
  )

  res <- fp_oa_parse_works(x)

  expect_s3_class(res, "data.frame")

  expect_named(
    res,
    c(
      "id",
      "authors",
      "title",
      "publication_year",
      "source_display_name",
      "source_id",
      "doi",
      "cited_by_count",
      "type"
    )
  )

  expect_equal(
    res$authors,
    c("Jane Doe et al.", "Jane Doe")
  )

  expect_equal(
    res$id,
    c("W1", "W2")
  )

  expect_equal(
    res$source_id,
    c("S1", "S2")
  )

  expect_equal(
    res$doi,
    c("10.1000/abc", "10.1000/def")
  )
})


test_that("fp_oa_parse_works() works - No results", {

  x <- data.frame()

  res <- fp_oa_parse_works(x)

  expect_s3_class(res, "data.frame")

  expect_named(
    res,
    c(
      "id",
      "authors",
      "title",
      "publication_year",
      "source_display_name",
      "source_id",
      "doi",
      "cited_by_count",
      "type"
    )
  )

  expect_equal(nrow(res), 0)

  expect_type(res$id, "character")
  expect_type(res$authors, "character")
  expect_type(res$title, "character")
  expect_type(res$publication_year, "integer")
  expect_type(res$cited_by_count, "integer")
})
