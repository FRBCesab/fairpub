## fp_shorten_string() ----

test_that("fp_shorten_string() works", {
  expect_silent(res <- fp_shorten_string(article_title, 100))
  expect_equal(res, article_title)

  expect_silent(res <- fp_shorten_string(article_title, 30))
  expect_equal(res, "Citation self-awareness...")
})
