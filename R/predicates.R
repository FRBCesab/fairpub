#' @keywords internal
is_string <- function(x) {
  is.character(x) && length(x) == 1L && !is.na(x)
}


#' @keywords internal
is_character <- function(x) {
  is.character(x) && length(x) > 0L
}


#' @keywords internal
is_number <- function(x) {
  is.numeric(x) && length(x) == 1L && !is.na(x)
}


#' @keywords internal
is_positive_integer <- function(x) {
  length(x) == 1L &&
    ((is.integer(x) && all(!is.na(x))) &&
      all(is.finite(x)) ||
      (is.numeric(x) &&
        all(!is.na(x)) &&
        all(is.finite(x)) &&
        all(x == trunc(x)))) &&
    x > 0
}


#' @keywords internal
is_between <- function(x, lower, upper) {
  if (!is.numeric(x) || length(x) == 0L || any(is.na(x))) {
    return(FALSE)
  }

  if (!is.numeric(lower) || length(lower) != 1L || is.na(lower)) {
    return(FALSE)
  }

  if (!is.numeric(upper) || length(upper) != 1L || is.na(upper)) {
    return(FALSE)
  }

  all(x >= lower & x <= upper)
}


#' @keywords internal
is_not_na <- function(x) {
  length(x) > 0L && !anyNA(x)
}


#' @keywords internal
is_starting_with <- function(x, prefix, ignore_case = TRUE) {
  if (!is.character(x) || length(x) == 0L || any(is.na(x))) {
    return(FALSE)
  }

  if (!is.character(prefix) || length(prefix) != 1L || is.na(prefix)) {
    return(FALSE)
  }

  if (ignore_case) {
    x <- tolower(x)
    prefix <- tolower(prefix)
  }

  all(startsWith(x, prefix))
}


#' @keywords internal
is_flag <- function(x) {
  is.logical(x) && length(x) == 1L && !is.na(x)
}


#' @keywords internal
is_file <- function(x) {
  is.character(x) && length(x) == 1L && !is.na(x) && file.exists(x)
}


is_one_of <- function(x, values) {
  if (!is.character(x) || length(x) != 1L || is.na(x)) {
    return(FALSE)
  }

  if (!is.character(values) || length(values) == 0L || any(is.na(values))) {
    return(FALSE)
  }

  x %in% values
}
