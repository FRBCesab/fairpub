## fp_identify_duplicate_works() ----

test_that("fp_identify_duplicate_works() - Create 'ref_id' column", {
  df <- data.frame(
    title = c(
      "Deep Learning for NLP",
      "Deep learning for NLP",
      "Quantum Computing Basics"
    ),
    stringsAsFactors = FALSE
  )

  res <- fp_identify_duplicate_works(df)

  expect_s3_class(res, "data.frame")
  expect_true("ref_id" %in% names(res))
  expect_type(res$ref_id, "integer")
  expect_equal(nrow(res), 3)
})

test_that("fp_identify_duplicate_works() - Cluster works", {
  df <- data.frame(
    title = c(
      "Deep Learning for NLP",
      "deep learning for x-nlp",
      "Quantum Computing Basics"
    ),
    stringsAsFactors = FALSE
  )

  res <- fp_identify_duplicate_works(df, threshold = 0.2)

  expect_equal(res$ref_id[1], res$ref_id[2])
  expect_false(res$ref_id[1] == res$ref_id[3])
})

test_that("fp_identify_duplicate_works() - Normalize", {
  df <- data.frame(
    title = c(
      "Deep Learning for NLP",
      " deep learning for nlp ",
      "Deep-Learning for NLP!!!"
    ),
    stringsAsFactors = FALSE
  )

  res <- fp_identify_duplicate_works(df)

  expect_equal(length(unique(res$ref_id)), 1)
})

test_that("fp_identify_duplicate_works() - String w/ NA", {
  df <- data.frame(
    title = c(
      NA,
      "",
      "Machine Learning"
    ),
    stringsAsFactors = FALSE
  )

  expect_no_error(
    res <- fp_identify_duplicate_works(df)
  )

  expect_true("ref_id" %in% names(res))
  expect_equal(nrow(res), 3)
})

test_that("fp_identify_duplicate_works() - Keep original columns", {
  df <- data.frame(
    id = 1:3,
    title = c(
      "A",
      "A",
      "B"
    ),
    year = c(2020, 2021, 2022),
    stringsAsFactors = FALSE
  )

  res <- fp_identify_duplicate_works(df)

  expect_named(
    res,
    c("id", "title", "year", "ref_id")
  )

  expect_equal(res$id, 1:3)
  expect_equal(res$year, c(2020, 2021, 2022))
})

test_that("fp_identify_duplicate_works() - Threshold", {
  df <- data.frame(
    title = c(
      "Deep Learning",
      "Deep Learning Methods"
    ),
    stringsAsFactors = FALSE
  )

  res_low <- fp_identify_duplicate_works(
    df,
    threshold = 0.05
  )

  res_high <- fp_identify_duplicate_works(
    df,
    threshold = 0.8
  )

  expect_false(
    res_low$ref_id[1] == res_low$ref_id[2]
  )

  expect_equal(
    res_high$ref_id[1],
    res_high$ref_id[2]
  )
})
