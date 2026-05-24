#' Helper: if x is NULL then y
#' @noRd
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

#' @noRd

fp_check_mailto <- function() {
  if (is.null(options()$"openalexR.mailto")) {
    stop(
      "Be polite with OpenAlex API and run: ",
      "`options(openalexR.mailto = 'your_email')`"
    )
  }

  invisible(NULL)
}

#' @noRd
fp_extract_doi_from_bibentry <- function(bibentry) {
  vapply(
    bibentry,
    \(x) x$doi %||% NA_character_,
    character(1),
    USE.NAMES = FALSE
  )
}

#' @noRd
fp_read_bibtex <- function(file) {
  bibtex::read.bib(file)
}
