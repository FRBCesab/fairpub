#' Extract DOI from a BibTeX file or a string
#'
#' @description
#' This function detects and extracts DOI from bibliographic records. User can
#' provides either a `character` vector (argument `x`) or the path to a BibTex
#' file (argument `file`).
#'
#' @param x a `character` vector. A string containing bibliographic records.
#'
#' @param file a `character` of length 1. The path to the BibTeX file to open.
#'
#' @return
#' A `character` vector with extracted DOI. Some values can be `NA` in case of
#' books, chapters, etc. or if references are malformed in the BibTeX.
#'
#' @export
#'
#' @examples
#' # Argument 'x' (one DOI per element) ----
#' string <- c(
#'   "Beck M (2026) Citation self-awareness... 10.1093/biosci/biag028.",
#'   "Galtier N (2026) Time to publish... DOI: 10.32942/X24933",
#'   "Doe J (9999) Title... http://dx.doi.org/10.1162/qss(c)_00305",
#'   "Receveur A (2024) David vs Goliath... https://doi.org/10.1111/ele.14395",
#'   "Smith J (9999) This is a fake article."
#' )
#'
#' ## Extract DOI from a vector ----
#' fp_extract_doi(x = string)
#'
#' # Argument 'x' (many DOI per element) ----
#' string <- paste(string, collapse = "\n")
#' cat(string)
#'
#' ## Extract DOI from a vector ----
#' fp_extract_doi(x = string)
#'
#' # Argument 'file' ----
#'
#' ## Path to the BibTeX provided by <fairpub> ----
#' filename <- system.file(
#'   file.path("extdata", "references.bib"),
#'   package = "fairpub"
#' )
#'
#' ## Extract DOI from BibTeX ----
#' fp_extract_doi(file = filename)

fp_extract_doi <- function(x = NULL, file = NULL) {
  assert_exactly_one(x, file)

  if (!is.null(x)) {
    assert_character(x)

    dois <- fp_extract_doi_from_string(x)
  } else {
    assert_file(file, "file")

    dois <- fp_read_bibtex(file) |>
      fp_extract_doi_from_bibentry()
  }

  fp_clean_doi(dois)
}


#' @noRd
fp_read_bibtex <- function(file) {
  bibtex::read.bib(file)
}


#' @noRd
fp_extract_doi_from_bibentry <- function(bibentry) {
  vapply(
    bibentry,
    \(x) if (!is.null(x$doi)) x$doi else NA_character_,
    character(1),
    USE.NAMES = FALSE
  )
}


#' @noRd
fp_extract_doi_from_string <- function(x) {
  matches <- regmatches(
    x,
    gregexpr(.DOI_REGEX, x, perl = TRUE, ignore.case = TRUE)
  )

  unlist(matches, use.names = FALSE)
}
