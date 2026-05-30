#' @keywords internal
abort_msg <- function(arg = NULL, msg, ...) {
  prefix <- if (is.null(arg)) {
    ""
  } else {
    sprintf("Argument `%s` ", arg)
  }

  stop(
    paste0(prefix, sprintf(msg, ...), "."),
    call. = FALSE
  )
}


#' @keywords internal
assert_string <- function(x, arg = "x") {
  if (!is_string(x)) {
    abort_msg(arg, "must be a character vector of length 1")
  }

  invisible(NULL)
}


#' @keywords internal
assert_character <- function(x, arg = "x") {
  if (!is_character(x)) {
    abort_msg(arg, "must be a character vector")
  }

  invisible(NULL)
}


#' @keywords internal
assert_number <- function(x, arg = "x") {
  if (!is_number(x)) {
    abort_msg(arg, "must be a number of length 1")
  }

  invisible(NULL)
}


#' @keywords internal
assert_positive_integer <- function(x, arg = "x") {
  if (!is_positive_integer(x)) {
    abort_msg(arg, "must be a positive integer of length 1")
  }

  invisible(NULL)
}


#' @keywords internal
assert_between <- function(x, lower = 1, upper = 200, arg = "x") {
  if (!is_between(x, lower, upper)) {
    abort_msg(arg, "must be between %s and %s", lower, upper)
  }

  invisible(NULL)
}


#' @keywords internal
assert_not_na <- function(x, arg = "x") {
  if (!is_not_na(x)) {
    abort_msg(arg, "must not contain `NA` values")
  }

  invisible(NULL)
}


#' @keywords internal
assert_starting_with <- function(x, prefix, arg = "x", ignore_case = TRUE) {
  if (!is_starting_with(x, prefix, ignore_case)) {
    abort_msg(
      arg,
      "must be a character vector whose elements all start with `%s`",
      prefix
    )
  }

  invisible(NULL)
}


#' @keywords internal
assert_flag <- function(x, arg = "x") {
  if (!is_flag(x)) {
    abort_msg(arg, "must be `TRUE` or `FALSE`")
  }

  invisible(NULL)
}


#' @keywords internal
assert_file <- function(x, arg = "x") {
  if (!is_file(x)) {
    stop(
      sprintf("File `%s` does not exist.", arg)
    )
  }

  invisible(NULL)
}


#' @keywords internal
assert_one_of <- function(x, values, pkg, arg = "x") {
  if (!is_one_of(x, values)) {
    abort_msg(
      arg,
      "is not a valid input for `%s()`. See `?%s` for details",
      pkg,
      pkg
    )
  }

  invisible(NULL)
}
