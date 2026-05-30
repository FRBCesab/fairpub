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
    writeLines("# README", "README.md")

    expect_invisible(assert_file("README.md"))
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
