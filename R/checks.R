#' @noRd
check_arg_file <- function(file) {
  if (missing(file)) {
    stop("Argument 'file' is required", call. = FALSE)
  }

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
