## fp_list_openalex_work_types() ----

test_that("fp_list_openalex_work_types() works", {
  res <- fp_list_openalex_work_types()

  expect_type(res, "character")
  expect_true(is.vector(res))

  expect_true("article" %in% res)
  expect_true("review" %in% res)
  expect_true("letter" %in% res)

  expect_false(any(duplicated(res)))
})
