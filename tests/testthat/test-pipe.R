## `%||%` ----

test_that("%||% works", {
  expect_equal("Value 1" %||% "Value 2", "Value 1")
  expect_equal(NULL %||% "Value 2", "Value 2")
  expect_equal("Value 1" %||% NULL, "Value 1")

  expect_equal(1 %||% 2, 1L)
  expect_equal(NULL %||% 2, 2L)
  expect_equal(1 %||% NULL, 1L)
})
