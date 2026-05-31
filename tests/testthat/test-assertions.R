# abort_msg() & assert_*() ----

test_that("abort_msg() works)", {
  expect_error(
    abort_msg("x", "must be numeric"),
    "Argument `x` must be numeric.",
    fixed = TRUE
  )

  expect_error(
    abort_msg(NULL, "must be numeric"),
    "must be numeric.",
    fixed = TRUE
  )

  expect_error(
    abort_msg("x", "must be between %d and %d", 1, 10),
    "Argument `x` must be between 1 and 10.",
    fixed = TRUE
  )

  expect_error(
    abort_msg("x", ""),
    "Argument `x` .",
    fixed = TRUE
  )

  err <- tryCatch(
    abort_msg("x", "invalid value"),
    error = function(e) e
  )

  expect_false(grepl("abort_msg", err$message))
})


test_that("assert_string() works", {
  expect_invisible(assert_string("abc"))

  expect_error(
    assert_string(123),
    "Argument `x` must be a character vector of length 1."
  )

  expect_error(
    assert_string(123, arg = "file"),
    "Argument `file` must be a character vector of length 1."
  )

  expect_error(
    assert_string(NA_character_),
    "Argument `x` must be a character vector of length 1."
  )
})


test_that("assert_character() works", {
  expect_invisible(assert_character(""))
  expect_invisible(assert_character("a"))
  expect_invisible(assert_character(c("a", "b")))
  expect_invisible(assert_character(c("a", "")))
  expect_invisible(assert_character(c("a", NA)))
  expect_invisible(assert_character(character(1L)))

  expect_error(
    assert_character(123),
    "Argument `x` must be a character vector."
  )

  expect_error(
    assert_character(123, arg = "file"),
    "Argument `file` must be a character vector."
  )
})


test_that("assert_number() works", {
  expect_invisible(assert_number(1L))
  expect_invisible(assert_number(3.14))
  expect_invisible(assert_number(-10))

  expect_error(
    assert_number("a"),
    "Argument `x` must be a number of length 1."
  )

  expect_error(
    assert_number(c(1, 2)),
    "Argument `x` must be a number of length 1."
  )

  expect_error(
    assert_number("a", arg = "file"),
    "Argument `file` must be a number of length 1."
  )

  expect_error(
    assert_number(NA),
    "Argument `x` must be a number of length 1."
  )
})


test_that("assert_positive_integer() works", {
  expect_invisible(assert_positive_integer(1))
  expect_invisible(assert_positive_integer(1L))

  expect_error(
    assert_positive_integer(0),
    "Argument `x` must be a positive integer of length 1."
  )

  expect_error(
    assert_positive_integer(-1),
    "Argument `x` must be a positive integer of length 1."
  )

  expect_error(
    assert_positive_integer(1.5),
    "Argument `x` must be a positive integer of length 1."
  )

  expect_error(
    assert_positive_integer(c(1, 2L)),
    "Argument `x` must be a positive integer of length 1."
  )

  expect_error(
    assert_positive_integer("a", arg = "n"),
    "Argument `n` must be a positive integer of length 1."
  )

  expect_error(
    assert_positive_integer(NA),
    "Argument `x` must be a positive integer of length 1."
  )
})


test_that("assert_between() works", {
  expect_invisible(assert_between(1))
  expect_invisible(assert_between(200))
  expect_invisible(assert_between(c(50, 150)))
  expect_invisible(assert_between(5, lower = 0, upper = 10))

  expect_error(
    assert_between(0),
    "Argument `x` must be between 1 and 200."
  )

  expect_error(
    assert_between(201),
    "Argument `x` must be between 1 and 200."
  )

  expect_error(
    assert_between(c(50, 250)),
    "Argument `x` must be between 1 and 200."
  )

  expect_error(
    assert_between(15, lower = 0, upper = 10),
    "Argument `x` must be between 0 and 10"
  )

  expect_error(
    assert_between(0, arg = "n"),
    "Argument `n` must be between 1 and 200."
  )

  expect_error(
    assert_between(NA),
    "Argument `x` must be between 1 and 200."
  )
})


test_that("assert_not_na() works", {
  expect_invisible(assert_not_na(1))
  expect_invisible(assert_not_na(c(1, 2, 3)))
  expect_invisible(assert_not_na("a"))
  expect_invisible(assert_not_na(c("a", "b")))
  expect_invisible(assert_not_na(TRUE))

  expect_error(
    assert_not_na(NA),
    "Argument `x` must not contain `NA` values."
  )

  expect_error(
    assert_not_na(c(1, NA)),
    "Argument `x` must not contain `NA` values."
  )

  expect_error(
    assert_not_na(character(0)),
    "Argument `x` must not contain `NA` values."
  )

  expect_error(
    assert_not_na(c(1, NA), arg = "z"),
    "Argument `z` must not contain `NA` values."
  )
})


test_that("assert_starting_with()", {
  expect_invisible(assert_starting_with("ABC", "A"))
  expect_invisible(assert_starting_with(c("AAA", "ABC"), "A"))
  expect_invisible(assert_starting_with(c("AAA", "ABC"), "a"))

  expect_error(
    assert_starting_with(c("AAA", "BBB"), "AAA"),
    paste0(
      "Argument `x` must be a character vector whose elements all ",
      "start with `AAA`"
    )
  )

  expect_error(
    assert_starting_with("BBB", "AAA"),
    paste0(
      "Argument `x` must be a character vector whose elements all ",
      "start with `AAA`"
    )
  )

  expect_error(
    assert_starting_with(c("aaa", "bbb"), "A", ignore_case = FALSE),
    paste0(
      "Argument `x` must be a character vector whose elements all ",
      "start with `A`"
    )
  )

  expect_error(
    assert_starting_with(c("BBB"), "AAA", arg = "z"),
    paste0(
      "Argument `z` must be a character vector whose elements all ",
      "start with `AAA`"
    )
  )

  expect_error(
    assert_starting_with(NA, "A"),
    paste0(
      "Argument `x` must be a character vector whose elements all ",
      "start with `A`"
    )
  )

  expect_error(
    assert_starting_with(c("A", NA), "A"),
    paste0(
      "Argument `x` must be a character vector whose elements all ",
      "start with `A`"
    )
  )

  expect_error(
    assert_starting_with(c(1, 2), "A"),
    paste0(
      "Argument `x` must be a character vector whose elements all ",
      "start with `A`"
    )
  )
})


test_that("assert_flag() works", {
  expect_invisible(assert_flag(TRUE))
  expect_invisible(assert_flag(FALSE))

  expect_error(
    assert_flag(1),
    "Argument `x` must be `TRUE` or `FALSE`."
  )

  expect_error(
    assert_flag("TRUE"),
    "Argument `x` must be `TRUE` or `FALSE`."
  )

  expect_error(
    assert_flag(c(TRUE, FALSE)),
    "Argument `x` must be `TRUE` or `FALSE`."
  )

  expect_error(
    assert_flag(NA),
    "Argument `x` must be `TRUE` or `FALSE`."
  )

  expect_error(
    assert_flag(1, arg = "z"),
    "Argument `z` must be `TRUE` or `FALSE`."
  )
})


test_that("assert_file() works", {
  withr::with_tempfile("tmp", {
    writeLines("# README", tmp)
    expect_invisible(assert_file(tmp))
  })

  expect_error(
    assert_file("Missing-file.md"),
    "Argument `x`: file `Missing-file.md` does not exist.",
    fixed = TRUE
  )

  expect_error(
    assert_file("Missing-file.md", arg = "file"),
    "Argument `file`: file `Missing-file.md` does not exist.",
  )
})


test_that("assert_one_of() works", {
  expect_invisible(assert_one_of("A", values = c("A", "B"), pkg = "fun"))
  expect_invisible(assert_one_of("B", values = c("A", "B"), pkg = "fun"))

  expect_error(
    assert_one_of("C", values = c("A", "B"), pkg = "fun"),
    paste0(
      "Argument `x` is not a valid input for `fun\\(\\)`. ",
      "See `\\?fun` for details."
    )
  )

  expect_error(
    assert_one_of("a", values = c("A", "B"), pkg = "fun"),
    paste0(
      "Argument `x` is not a valid input for `fun\\(\\)`. ",
      "See `\\?fun` for details."
    )
  )

  expect_error(
    assert_one_of("C", values = c("A", "B"), pkg = "fun", arg = "method"),
    paste0(
      "Argument `method` is not a valid input for `fun\\(\\)`. ",
      "See `\\?fun` for details."
    )
  )

  expect_error(assert_one_of(NA, values = c("A", "B"), pkg = "fun"))
  expect_error(assert_one_of(1, values = c("A", "B"), pkg = "fun"))
  expect_error(assert_one_of(c("A", "B"), values = c("A", "B"), pkg = "fun"))
})


test_that("assert_dataframe() works", {
  expect_invisible(assert_dataframe(data.frame(x = 1:2, y = c("a", "b"))))

  expect_error(
    assert_dataframe(12),
    "Argument `data` must be a non-empty data frame.",
    fixed = TRUE
  )

  expect_error(
    assert_dataframe(data.frame()),
    "Argument `data` must be a non-empty data frame.",
    fixed = TRUE
  )

  expect_error(
    assert_dataframe(data.frame(x = character(0))),
    "Argument `data` must be a non-empty data frame.",
    fixed = TRUE
  )

  expect_error(
    assert_dataframe(data.frame(), "df"),
    "Argument `df` must be a non-empty data frame.",
    fixed = TRUE
  )
})


test_that("assert_has_column() works", {
  df <- data.frame(x = 1:2, y = c("a", "b"))

  expect_invisible(assert_has_column(df, "x"))

  expect_error(
    assert_has_column(12, "x"),
    "Argument `data` must contain a column named `x`.",
    fixed = TRUE
  )

  expect_error(
    assert_has_column(data.frame(), "x"),
    "Argument `data` must contain a column named `x`.",
    fixed = TRUE
  )

  expect_error(
    assert_has_column(data.frame(), "x", "df"),
    "Argument `df` must contain a column named `x`.",
    fixed = TRUE
  )

  expect_error(
    assert_has_column(df, "X"),
    "Argument `data` must contain a column named `X`.",
    fixed = TRUE
  )

  expect_error(
    assert_has_column(df, "z"),
    "Argument `data` must contain a column named `z`.",
    fixed = TRUE
  )
})


test_that("assert_exactly_one() works", {
  expect_invisible(assert_exactly_one(12, NULL))
  expect_invisible(assert_exactly_one(NULL, 12))

  expect_error(
    assert_exactly_one(NULL, NULL),
    "Exactly one of `x` and `file` must be supplied.",
    fixed = TRUE
  )

  expect_error(
    assert_exactly_one(12, 12),
    "Exactly one of `x` and `file` must be supplied.",
    fixed = TRUE
  )

  expect_error(
    assert_exactly_one(NULL, NULL, arg_names = c("y", "z")),
    "Exactly one of `y` and `z` must be supplied.",
    fixed = TRUE
  )
})


test_that("assert_if_valid_work_type() works", {
  expect_no_error(
    assert_if_valid_work_type("article")
  )

  expect_no_error(
    assert_if_valid_work_type(c("article", "book", "review"))
  )

  result <- assert_if_valid_work_type("article")
  expect_null(result)

  valid_types <- fp_list_openalex_work_types()

  expect_no_error(
    assert_if_valid_work_type(valid_types)
  )

  expect_error(
    assert_if_valid_work_type("foobar"),
    regexp = "Invalid `select` argument"
  )

  expect_error(
    assert_if_valid_work_type(c("article", "foobar")),
    regexp = "Invalid `select` argument"
  )
})
