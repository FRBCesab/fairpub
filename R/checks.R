#' @noRd
check_arg_file <- function(file) {
  if (is.null(file)) {
    stop("Argument 'file' is required", call. = FALSE)
  }

  if (!is.character(file)) {
    stop(
      "Argument 'file' must be a character (BibTeX file name)",
      call. = FALSE
    )
  }

  if (length(file) != 1) {
    stop("Argument 'file' must be of length 1 (one BibTeX file)", call. = FALSE)
  }

  if (!file.exists(file)) {
    stop("The file '", file, "' does not exist", call. = FALSE)
  }

  invisible(NULL)
}


#' @noRd
check_arg_doi <- function(doi) {
  if (missing(doi)) {
    stop("Argument 'doi' is required", call. = FALSE)
  }

  if (is.null(doi)) {
    stop("Argument 'doi' is required", call. = FALSE)
  }

  if (!is.character(doi)) {
    stop("Argument 'doi' must be a character", call. = FALSE)
  }

  invisible(NULL)
}


#' @noRd
check_exactly_one_arg <- function(x, file) {
  n <- sum(!is.null(x), !is.null(file))

  if (n != 1) {
    stop(
      "You must supply exactly one of 'x' or 'file'",
      call. = FALSE
    )
  }

  invisible(NULL)
}


#' @noRd
check_arg_string <- function(x) {
  if (is.null(x)) {
    stop("Argument 'x' is required", call. = FALSE)
  }

  if (!is.character(x)) {
    stop(
      "Argument 'x' must be a character",
      call. = FALSE
    )
  }

  invisible(NULL)
}


#' @noRd
check_arg_n <- function(n) {
  if (is.null(n)) {
    stop("Argument 'n' is required", call. = FALSE)
  }

  if (!is.numeric(n)) {
    stop(
      "Argument 'n' must be an integer",
      call. = FALSE
    )
  }

  if (length(n) != 1) {
    stop(
      "Argument 'n' must be of length 1",
      call. = FALSE
    )
  }

  if (!is.finite(n)) {
    stop(
      "Argument 'n' must be finite",
      call. = FALSE
    )
  }

  if (n %% 1 != 0) {
    stop(
      "Argument 'n' must be an integer",
      call. = FALSE
    )
  }

  if (n < 1 || n > 200) {
    stop(
      "Argument 'n' must be a positive integer between 1 and 200",
      call. = FALSE
    )
  }

  invisible(NULL)
}
