## is_*()

test_that("is_string() returns TRUE", {
  expect_true(is_string(""))
  expect_true(is_string(character(1)))
  expect_true(is_string("string"))
})

test_that("is_string() returns FALSE", {
  expect_false(is_string(12L))
  expect_false(is_string(12.5))
  expect_false(is_string(TRUE))
  expect_false(is_string(list()))
  expect_false(is_string(matrix()))
  expect_false(is_string(data.frame()))

  expect_false(is_string(NULL))
  expect_false(is_string(character(0)))
  expect_false(is_string(c("string", "string")))

  expect_false(is_string(NA))
  expect_false(is_string(NA_character_))
  expect_false(is_string(c("string", NA)))
})


test_that("is_character() returns TRUE", {
  expect_true(is_character(""))
  expect_true(is_character(character(1)))
  expect_true(is_character(character(2)))
  expect_true(is_character("string"))
  expect_true(is_character(c("string", "string")))
})

test_that("is_character() returns FALSE", {
  expect_false(is_character(12L))
  expect_false(is_character(rep(12L, 2)))
  expect_false(is_character(12.5))
  expect_false(is_character(rep(12.5, 2)))
  expect_false(is_character(TRUE))
  expect_false(is_character(list()))
  expect_false(is_character(matrix()))
  expect_false(is_character(data.frame()))

  expect_false(is_character(NULL))
  expect_false(is_character(character(0)))
})


test_that("is_number() returns TRUE", {
  expect_true(is_number(numeric(1)))
  expect_true(is_number(double(1)))
  expect_true(is_number(integer(1)))
  expect_true(is_number(12L))
  expect_true(is_number(12.5))
  expect_true(is_number(-12.5))
})

test_that("is_number() returns FALSE", {
  expect_false(is_number("string"))
  expect_false(is_number(TRUE))
  expect_false(is_number(list()))
  expect_false(is_number(matrix()))
  expect_false(is_number(data.frame()))

  expect_false(is_number(NULL))
  expect_false(is_number(numeric(0)))
  expect_false(is_number(integer(0)))
  expect_false(is_number(double(0)))
  expect_false(is_number(rep(12L, 2)))
  expect_false(is_number(rep(12.5, 2)))
  expect_false(is_number(rep(-12.5, 2)))

  expect_false(is_number(NA))
  expect_false(is_number(NA_integer_))
  expect_false(is_number(NA_real_))
  expect_false(is_number(c(12L, NA)))
  expect_false(is_number(c(12.5, NA)))
  expect_false(is_number(c(-12.5, NA)))
})


test_that("is_positive_integer() returns TRUE", {
  expect_true(is_positive_integer(1))
  expect_true(is_positive_integer(1L))
})

test_that("is_positive_integer() returns FALSE", {
  expect_false(is_positive_integer(NULL))
  expect_false(is_positive_integer(numeric(0)))
  expect_false(is_positive_integer(integer(0)))
  expect_false(is_positive_integer(double(0)))
  expect_false(is_positive_integer(rep(12L, 2)))
  expect_false(is_positive_integer(rep(12.5, 2)))
  expect_false(is_positive_integer(rep(-12.5, 2)))

  expect_false(is_positive_integer("string"))
  expect_false(is_positive_integer(TRUE))
  expect_false(is_positive_integer(list()))
  expect_false(is_positive_integer(matrix()))
  expect_false(is_positive_integer(data.frame()))

  expect_false(is_positive_integer(NA))
  expect_false(is_positive_integer(NA_integer_))
  expect_false(is_positive_integer(NA_real_))

  expect_false(is_positive_integer(Inf))
  expect_false(is_positive_integer(-Inf))

  expect_false(is_positive_integer(12.5))
  expect_false(is_positive_integer(-12.5))

  expect_false(is_positive_integer(0))
  expect_false(is_positive_integer(0L))
  expect_false(is_positive_integer(-12))
  expect_false(is_positive_integer(-12L))
})


test_that("is_between() returns TRUE", {
  expect_true(is_between(0, 0, 10))
  expect_true(is_between(10, 0, 10))

  expect_true(is_between(1, 0, 10))
  expect_true(is_between(0, -10, 10))
  expect_true(is_between(-20, -30, -10))

  expect_true(is_between(1L, 0, 10))
  expect_true(is_between(1L, 0L, 10L))
  expect_true(is_between(0L, -10L, 10L))
  expect_true(is_between(-20L, -30L, -10L))

  expect_true(is_between(1.5, 0, 10.5))
  expect_true(is_between(0, -10.5, 10.5))
  expect_true(is_between(-20.5, -30.5, -10.5))

  expect_true(is_between(rep(5, 2), 0L, 10L))
})

test_that("is_between() returns FALSE", {
  expect_false(is_between("string", 0, 10))
  expect_false(is_between(TRUE, 0, 10))
  expect_false(is_between(list(), 0, 10))
  expect_false(is_between(matrix(), 0, 10))
  expect_false(is_between(data.frame(), 0, 10))

  expect_false(is_between(NULL, 0, 10))
  expect_false(is_between(numeric(0), 0, 10))
  expect_false(is_between(integer(0), 0, 10))
  expect_false(is_between(double(0), 0, 10))

  expect_false(is_between(NA, 0, 10))
  expect_false(is_between(NA_integer_, 0, 10))
  expect_false(is_between(NA_real_, 0, 10))
  expect_false(is_between(c(12L, NA), 0, 10))
  expect_false(is_between(c(12.5, NA), 0, 10))
  expect_false(is_between(c(-12.5, NA), 0, 10))

  expect_false(is_between(0, NULL, 10))
  expect_false(is_between(0, -10, NULL))

  expect_false(is_between(0, "string", 10))
  expect_false(is_between(0, -10, "string"))

  expect_false(is_between(0, TRUE, 10))
  expect_false(is_between(0, -10, FALSE))

  expect_false(is_between(0, NA, 10))
  expect_false(is_between(0, -10, NA))

  expect_false(is_between(0, 1, 10))
  expect_false(is_between(-10, 0, 10))
  expect_false(is_between(-30, -20, -10))

  expect_false(is_between(0, 1L, 10))
  expect_false(is_between(0L, 1L, 10L))
  expect_false(is_between(-10L, 0L, 10L))
  expect_false(is_between(-30L, -20L, -10L))

  expect_false(is_between(0, 1.5, 10.5))
  expect_false(is_between(-10.5, 0, 10.5))
  expect_false(is_between(-30.5, -20.5, -10.5))

  expect_false(is_between(rep(-5, 2), 0L, 10L))
  expect_false(is_between(c(-5, 5), 0L, 10L))
})


test_that("is_not_na() returns TRUE", {
  expect_true(is_not_na(""))
  expect_true(is_not_na("string"))
  expect_true(is_not_na(character(1)))
  expect_true(is_not_na(rep("", 2)))
  expect_true(is_not_na(rep("string", 2)))
  expect_true(is_not_na(character(2)))

  expect_true(is_not_na(12L))
  expect_true(is_not_na(12.5))
  expect_true(is_not_na(integer(1)))
  expect_true(is_not_na(numeric(1)))
  expect_true(is_not_na(rep(12L, 2)))
  expect_true(is_not_na(rep(12.5, 2)))
  expect_true(is_not_na(integer(2)))
  expect_true(is_not_na(numeric(2)))

  expect_true(is_not_na(TRUE))
  expect_true(is_not_na(FALSE))
})

test_that("is_not_na() returns FALSE", {
  expect_false(is_not_na(NULL))
  expect_false(is_not_na(character(0)))
  expect_false(is_not_na(numeric(0)))
  expect_false(is_not_na(integer(0)))

  expect_false(is_not_na(NA))
  expect_false(is_not_na(NA_character_))
  expect_false(is_not_na(NA_integer_))
  expect_false(is_not_na(c(12, NA)))
  expect_false(is_not_na(c(12L, NA)))
  expect_false(is_not_na(c(12.5, NA)))
  expect_false(is_not_na(c(NA, "string")))
  expect_false(is_not_na(c(NA, NA)))
})


test_that("is_starting_with() returns TRUE", {
  expect_true(is_starting_with("A12345", "A"))
  expect_true(is_starting_with("a12345", "a"))
  expect_true(is_starting_with("a12345", "A", ignore_case = TRUE))
  expect_true(is_starting_with("A12345", "a", ignore_case = TRUE))

  expect_true(is_starting_with(rep("A12345", 2), "A"))
})

test_that("is_starting_with() returns FALSE", {
  expect_false(is_starting_with(12, "A"))
  expect_false(is_starting_with(TRUE, "A"))
  expect_false(is_starting_with(list(), "A"))
  expect_false(is_starting_with(matrix(), "A"))
  expect_false(is_starting_with(data.frame(), "A"))

  expect_false(is_starting_with(NULL, "A"))
  expect_false(is_starting_with(character(0), "A"))

  expect_false(is_starting_with(NA, "A"))
  expect_false(is_starting_with(NA_character_, "A"))
  expect_false(is_starting_with(c("A12345", NA), "A"))

  expect_false(is_starting_with("A12345", 12))
  expect_false(is_starting_with("A12345", TRUE))
  expect_false(is_starting_with("A12345", NULL))
  expect_false(is_starting_with("A12345", character(0)))
  expect_false(is_starting_with("A12345", rep("A", 2)))
  expect_false(is_starting_with("A12345", NA))
  expect_false(is_starting_with("A12345", NA_character_))

  expect_false(is_starting_with("W12345", "A"))
  expect_false(is_starting_with("W12345", "a"))
  expect_false(is_starting_with(c("A12345", "W12345"), "A"))
  expect_false(is_starting_with(c("A12345", "W12345"), "a"))
  expect_false(is_starting_with("a12345", "A", ignore_case = FALSE))
  expect_false(is_starting_with("A12345", "a", ignore_case = FALSE))
})


test_that("is_flag() returns TRUE", {
  expect_true(is_flag(logical(1)))
  expect_true(is_flag(TRUE))
  expect_true(is_flag(FALSE))
})

test_that("is_flag() returns FALSE", {
  expect_false(is_flag(12L))
  expect_false(is_flag(12.5))
  expect_false(is_flag("string"))
  expect_false(is_flag(list()))
  expect_false(is_flag(matrix()))
  expect_false(is_flag(data.frame()))

  expect_false(is_flag(NULL))
  expect_false(is_flag(logical(0)))
  expect_false(is_flag(c(TRUE, TRUE)))

  expect_false(is_flag(NA))
  expect_false(is_flag(c(TRUE, NA)))
})

test_that("is_file() returns TRUE", {
  withr::with_tempfile("tmp", {
    writeLines("# README", "README.md")
    expect_true(is_file("README.md"))
  })
})

test_that("is_file() returns FALSE", {
  expect_false(is_file(12L))
  expect_false(is_file(12.5))
  expect_false(is_file(TRUE))
  expect_false(is_file(list()))
  expect_false(is_file(matrix()))
  expect_false(is_file(data.frame()))

  expect_false(is_file(NULL))
  expect_false(is_file(character(0)))
  expect_false(is_file(c("string", "string")))

  expect_false(is_file(NA))
  expect_false(is_file(NA_character_))

  expect_false(is_file("Missing-file.md"))
})


test_that("is_one_of() returns TRUE", {
  expect_true(is_one_of("aaa", "aaa"))
  expect_true(is_one_of("aaa", c("aaa", "bbb")))
})

test_that("is_one_of() returns FALSE", {
  expect_false(is_one_of(12, "aaa"))
  expect_false(is_one_of(TRUE, "aaa"))
  expect_false(is_one_of(list(), "aaa"))
  expect_false(is_one_of(matrix(), "aaa"))
  expect_false(is_one_of(data.frame(), "aaa"))

  expect_false(is_one_of(NULL, "aaa"))
  expect_false(is_one_of(character(0), "aaa"))

  expect_false(is_one_of(NA, "aaa"))
  expect_false(is_one_of(NA_character_, "aaa"))

  expect_false(is_one_of("aaa", 12))
  expect_false(is_one_of("aaa", TRUE))
  expect_false(is_one_of("aaa", NULL))
  expect_false(is_one_of("aaa", character(0)))
  expect_false(is_one_of("aaa", NA))
  expect_false(is_one_of("aaa", NA_character_))

  expect_false(is_one_of("aaa", "bbb"))
  expect_false(is_one_of("aaa", "AAA"))
  expect_false(is_one_of("AAA", "aaa"))
  expect_false(is_one_of("aaa", c("bbb", "ccc")))
})


test_that("is_dataframe() returns TRUE", {
  expect_true(is_dataframe(data.frame(x = 1)))
  expect_true(is_dataframe(data.frame(x = 1:2, y = c("a", "b"))))
})

test_that("is_dataframe() returns FALSE", {
  expect_false(is_dataframe(12))
  expect_false(is_dataframe(12:16))
  expect_false(is_dataframe("aaa"))
  expect_false(is_dataframe(TRUE))
  expect_false(is_dataframe(list(x = 1)))
  expect_false(is_dataframe(matrix(1:4, ncol = 2)))

  expect_false(is_dataframe(data.frame()))
  expect_false(is_dataframe(data.frame(x = character(0))))
  expect_false(is_dataframe(data.frame(x = character(0), y = character(0))))
})


test_that("has_column() returns TRUE", {
  df <- data.frame(x = 1:2, y = c("a", "b"))

  expect_true(has_column(df, "x"))
  expect_true(has_column(df, "y"))
})

test_that("has_column() returns FALSE", {
  expect_false(has_column(12, "x"))
  expect_false(has_column(12:16, "x"))
  expect_false(has_column("aaa", "x"))
  expect_false(has_column(TRUE, "x"))
  expect_false(has_column(list(x = 1), "x"))
  expect_false(has_column(matrix(1:4, ncol = 2), "x"))

  df <- data.frame(x = 1:2, y = c("a", "b"))

  expect_false(has_column(df, 12))
  expect_false(has_column(df, TRUE))
  expect_false(has_column(df, list()))
  expect_false(has_column(df, matrix()))
  expect_false(has_column(df, data.frame()))

  expect_false(has_column(df, c("x", "y")))

  expect_false(has_column(df, ""))
  expect_false(has_column(df, NA))
  expect_false(has_column(df, NA_character_))

  expect_false(has_column(df, "z"))
  expect_false(has_column(df, "X"))
})


test_that("is_exactly_one() returns TRUE", {
  expect_true(is_exactly_one(NULL, 12))
  expect_true(is_exactly_one(12, NULL))
})

test_that("is_exactly_one() returns FALSE", {
  expect_false(is_exactly_one(NULL, NULL))
  expect_false(is_exactly_one(12, 14))
})
